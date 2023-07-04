import { Component } from '@angular/core';
import {FormControl, FormGroup} from "@angular/forms";
import * as XLSX from 'xlsx';

@Component({
  selector: 'app-mcq-add',
  templateUrl: './mcq-add.component.html',
  styleUrls: ['./mcq-add.component.css']
})

export class McqAddComponent {

  questionImagePreviewUrl: any;
  optionOneImagePreviewUrl: any;
  optionTwoImagePreviewUrl: any;
  optionThreeImagePreviewUrl: any;
  optionFourImagePreviewUrl: any;
  optionImagePreviewUrl = [null,null,null,null];
  public mcqForm = new FormGroup({
    question: new FormControl(''),
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
    correct_ans: new FormControl([]),
    explanation: new FormControl(''),
    explanation_img: new FormControl(null),
    hardness: new FormControl(),
    categories: new FormControl(),
    subject: new FormControl(),
    chapter: new FormControl(),
    problem_setter: new FormControl(),
    verified: new FormControl(),
    published: new FormControl(),
  });


  // In your component class


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


  // onQuestionImageChange(formControlName: string, event: any) {
  //   if (event.target.files && event.target.files.length) {
  //     const file = event.target.files[0];
  //     const reader = new FileReader();
  //
  //     reader.onload = (e: any) => {
  //       this.questionImagePreviewUrl = e.target.result;
  //     };
  //     reader.readAsDataURL(file);
  //   } else {``
  //     this.questionImagePreviewUrl = null;
  //   }
  // }
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
      default:
        break;
    }
  }



  onSubmit(): void {
    if (this.mcqForm.valid) {
      console.log("Form values:");
      console.log(this.mcqForm.value);
    } else {
      console.log("Please fill in all required fields.");
    }
  }
}
