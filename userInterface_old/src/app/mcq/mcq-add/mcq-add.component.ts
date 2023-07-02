import {Component} from '@angular/core';
import {FormArray, FormControl, FormGroup} from "@angular/forms";

@Component({
  selector: 'app-mcq-add',
  templateUrl: './mcq-add.component.html',
  styleUrls: ['./mcq-add.component.css']
})
export class McqAddComponent {
  public mcqForm = new FormGroup({
    question: new FormControl(''),
    questionImg: new FormControl(null),
    options: new FormArray([]),
    correctAns: new FormControl([]),
    explanation: new FormControl(''),
    explanationImg: new FormControl(null),
    hardness: new FormControl(),
    categories: new FormControl(),
    subject: new FormControl(),
    chapter: new FormControl(),
    point: new FormControl(),
    published: new FormControl(),
  });
}
