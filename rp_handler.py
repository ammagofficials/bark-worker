import runpod
from transformers import AutoProcessor, BarkModel
import scipy.io.wavfile
import torch
import io
import base64


def handler(event):
    print("Worker Start")
    input = event['input']

    prompt = input.get('prompt', "Hey, I am an awesome AI")
    voice_preset = input.get("speaker", "v2/en_speaker_6")

    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"Using device: {device}")

    # Load processor and model
    processor = AutoProcessor.from_pretrained("suno/bark")
    model = BarkModel.from_pretrained("suno/bark", torch_dtype=torch.float32).to(device)

    # Prepare inputs and move to correct device
    inputs = processor(prompt, voice_preset=voice_preset, return_tensors="pt")
    inputs = {key: value.to(device) for key, value in inputs.items()}

    # Generate audio
    audio_array = model.generate(**inputs)
    audio_array = audio_array.cpu().numpy().squeeze()
    sample_rate = model.generation_config.sample_rate

    # Write audio to memory buffer instead of saving to file
    buffer = io.BytesIO()
    scipy.io.wavfile.write(buffer, rate=sample_rate, data=audio_array)
    buffer.seek(0)

    # Encode buffer content to base64
    audio_base64 = base64.b64encode(buffer.read()).decode('utf-8')

    return {
        "status": "success",
        "text": prompt,
        "audio_base64": audio_base64,
        "sample_rate": sample_rate,
        "format": "wav",
        "device":device
    }


if __name__ == '__main__':
    runpod.serverless.start({'handler': handler})
