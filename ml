from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
#from ru import *
model_name = "IlyaGusev/fred_t5_ru_turbo_alpaca"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForSeq2SeqLM.from_pretrained(model_name).to("cuda")
model.eval()

with open('your_story.txt', mode='r') as file:
      tasks_dict = eval(file.read)
      today_tasks = tasks_dict[datetime.now().date]
input = []
for list in today_tasks:
    a = f'Задание: Сочини короткое сообщение, обязательно упоминая следующие слова.\n{list[0]}'
    input.append(a)

from transformers import GenerationConfig

generation_config = GenerationConfig.from_pretrained(model_name)

for sample in inputs:
    data = tokenizer(sample, return_tensors="pt")
    data = {k: v.to(model.device) for k, v in data.items()}
    output_ids = model.generate(
        **data,
        generation_config=generation_config
    )[0]
    print(tokenizer.decode(data["input_ids"][0].tolist()))
    print(tokenizer.decode(output_ids.tolist()))
    print("====================")
