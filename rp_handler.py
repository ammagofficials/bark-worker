import runpod
from transformers import AutoProcessor, BarkModel
import scipy
import torch
def handler(event):
    print(f"Worker Start")
    input = event['input']
    
    prompt = input.get('prompt')

    device = "cuda" if torch.cuda.is_available() else "cpu"
    model = BarkModel.from_pretrained("suno/bark", torch_dtype=torch.float16).to(device)
    model.enable_cpu_offload()
    # model = model.to_bettertransformer()
    print(device+ " used")
    processor = AutoProcessor.from_pretrained("suno/bark")
    voice_preset = "v2/en_speaker_2"

    inputs = processor("Hello, my dog is cute", voice_preset=voice_preset)

    audio_array = model.generate(**inputs)
    audio_array = audio_array.cpu().numpy().squeeze()
    sample_rate = model.generation_config.sample_rate
    scipy.io.wavfile.write("bark_out.wav", rate=sample_rate, data=audio_array)
    return prompt 

if __name__ == '__main__':
    runpod.serverless.start({'handler': handler })
