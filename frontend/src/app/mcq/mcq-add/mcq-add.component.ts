import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import * as XLSX from 'xlsx';
import {McqService} from "../mcq.service";

@Component({
  selector: 'app-mcq-add',
  templateUrl: './mcq-add.component.html',
  styleUrls: ['./mcq-add.component.css']
})




export class McqAddComponent implements OnInit {

  questionImagePreviewUrl: any;
  optionOneImagePreviewUrl: any;
  optionTwoImagePreviewUrl: any;
  optionThreeImagePreviewUrl: any;
  optionFourImagePreviewUrl: any;
  explanationImagePreviewUrl: any;
  selectedSubject:any;

  subjects :any;
  category :any;
  hardness :any;
  problem_setter:any;

  mcqForm = new FormGroup({
  question: new FormControl('', Validators.required),
  question_img: new FormControl(null),
  option_text_1: new FormControl(null),
  option_img_1: new FormControl(null),
  option_text_2: new FormControl(null),
  option_img_2: new FormControl(null),
  option_text_3: new FormControl(null),
  option_img_3: new FormControl(null),
  option_text_4: new FormControl(null),
  option_img_4: new FormControl(null),
  option_text_5: new FormControl(null),
  option_img_5: new FormControl(null),
  correct_ans: new FormControl(null,Validators.required),
  explanation: new FormControl('',Validators.required),
  explanation_img: new FormControl(null),
  hardness: new FormControl(null, Validators.required), // Add Validators.required
  categories: new FormControl(null,Validators.required),
  subject: new FormControl(null,Validators.required),
  chapter: new FormControl({ value: null, disabled: true }),
  problem_setter: new FormControl(),
  verified: new FormControl({ value: false, disabled: true }),
  published: new FormControl({ value: false, disabled: true }),
});



ngOnInit() {
    this.getConText();
  }





  constructor(private mcqService: McqService) {}
  getConText(){
    this.mcqService.getMcqAddContext().subscribe({
      next: (response)=>{
        this.subjects = Object.values(response.data.subject);
        this.category = response.data.category;
        this.hardness = response.data.hardness;
        this.problem_setter = response.data.problem_setter;
        console.log(this.subjects);
      },
      error: (err)=>{
        console.log(err.status_code);
        console.log(err.error);
        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete:()=>{}
    });
  }

  // In your component class

  selectSubjectChange(event:any){
    // @ts-ignore
    this.selectedSubject = this.subjects.find(subject=> subject.name === event.value);
    this.selectedSubject = this.selectedSubject.chapters;
    if (this.selectedSubject) {
      this.mcqForm.get('chapter')?.enable();
    } else {
      this.mcqForm.get('chapter')?.disable();
    }
  }
  onExcelUpload(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    if (file) {
      this.readExcelData(file);
    }
  }

  readExcelData(file: File): void {
    const fileReader = new FileReader();
    fileReader.onload = (e: any) => {
      const data = e.target.result;
      const workbook = XLSX.read(data, { type: 'binary' });
      const firstSheetName = workbook.SheetNames[0];
      const worksheet = workbook.Sheets[firstSheetName];
      const jsonData = XLSX.utils.sheet_to_json(worksheet);
      console.log(jsonData);
    };
    fileReader.readAsBinaryString(file);
  }

  onImageChange(formControlName: string, event: any) {
    if (event.target.files && event.target.files.length) {
      const file = event.target.files[0];
      const reader = new FileReader();

      reader.onload = (e: any) => {
        switch (formControlName) {
          case 'question':
            this.questionImagePreviewUrl = e.target.result;
            break;
          case 'option_1':
            this.optionOneImagePreviewUrl = e.target.result;
            break;
          case 'option_2':
            this.optionTwoImagePreviewUrl = e.target.result;
            break;
          case 'option_3':
            this.optionThreeImagePreviewUrl = e.target.result;
            break;
          case 'option_4':
            this.optionFourImagePreviewUrl = e.target.result;
            break;
          case 'explanation':
            this.explanationImagePreviewUrl = e.target.result;
            break;
          default:
            break;
        }
      };
      reader.readAsDataURL(file);
    }
  }

  cancelImage(formControlName: string,){
    switch (formControlName) {
      case 'question':
        this.questionImagePreviewUrl = null;
        break;
      case 'option_1':
        this.optionOneImagePreviewUrl = null;
        break;
      case 'option_2':
        this.optionTwoImagePreviewUrl = null;
        break;
      case 'option_3':
        this.optionThreeImagePreviewUrl = null;
        break;
      case 'option_4':
        this.optionFourImagePreviewUrl = null;
        break;
      case 'explanation':
        this.explanationImagePreviewUrl = null;
        break;
      default:
        break;
    }
  }


  formToDictionary(): { [key: string]: any } {
    const formValue = this.mcqForm.value;
    const dictionary: { [key: string]: any } = {};

    Object.keys(formValue).forEach((key) => {
      // @ts-ignore
      dictionary[key] = formValue[key] || '';

    });

    return dictionary;
  }

  onSubmit(): void {
  console.log(this.mcqForm.value);

    if (this.mcqForm.valid) {


      // const formData = this.mcqForm.value;
      // console.log(this.mcqForm.value.question || '')
      //
      //
      // formData.append('question', this.mcqForm.value.question || '');
      // console.log(formData);
      // formData.append('option_text_1', this.mcqForm.value.option_text_1 || '');
      // formData.append('option_text_2', this.mcqForm.value.option_text_2 || '');
      // formData.append('option_text_3', this.mcqForm.value.option_text_3 || '');
      // formData.append('option_text_4', this.mcqForm.value.option_text_4 || '');
      // formData.append('option_text_5', this.mcqForm.value.option_text_5 || '');
      // formData.append('correct_ans', this.mcqForm.value.option_text_5 || '');
      // formData.append('explanation', this.mcqForm.value.option_text_5 || '');
      // formData.append('subject', this.mcqForm.value.option_text_5 || '');
      // formData.append('chapter', this.mcqForm.value.option_text_5 || '');
      // formData.append('hardness', this.mcqForm.value.option_text_5 || '');
      // formData.append('categories', this.mcqForm.value.option_text_5 || '');
      // formData.append('problem_setter', this.mcqForm.value.option_text_5 || '');
      // formData.append('verified', this.mcqForm.value.option_text_5 || '');
      // formData.append('published', this.mcqForm.value.option_text_5 || '');
      // console.log(formData);
      // formData.append('question_img_url', this.questionImagePreviewUrl?? this.mcqForm.value.question_img);
      // formData.append('option_img_url_1', this.optionOneImagePreviewUrl?? this.mcqForm.value.option_img_1);
      // formData.append('option_img_url_2', this.optionTwoImagePreviewUrl?? this.mcqForm.value.option_img_2);
      // formData.append('option_img_url_3', this.optionThreeImagePreviewUrl?? this.mcqForm.value.option_img_3);
      // formData.append('option_img_url_4', this.optionFourImagePreviewUrl?? this.mcqForm.value.option_img_4);
      // formData.append('option_img_url_5', "");
      // formData.append('explanation_img', this.explanationImagePreviewUrl?? this.mcqForm.value.explanation_img);
      // console.log(formData);
      this.mcqService.addNewMcq(this.formToDictionary(),
        this.questionImagePreviewUrl,
        this.optionOneImagePreviewUrl,
        this.optionTwoImagePreviewUrl,
        this.optionThreeImagePreviewUrl,
        this.optionFourImagePreviewUrl,
        this.explanationImagePreviewUrl
      ).subscribe({
        next: (response)=>{
          console.log(response);
        },
        error: (err)=>{
          console.log(err.status_code);
          console.log(err.error);
          console.log(err.error.status);
          console.log(err.error.errors);
          console.log(err.error.message);
        },
        complete:()=>{}
      });

    } else {
      console.log("Please fill in all required fields.");
    }
  }

}


