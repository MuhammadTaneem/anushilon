import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { QuestionBankRoutingModule } from './question-bank-routing.module';
import { QuestionBankAddComponent } from './question-bank-add/question-bank-add.component';
import { QuestionBankDetailsComponent } from './question-bank-details/question-bank-details.component';
import {MaterialModule} from "../material/material.module";



@NgModule({
  declarations: [
    QuestionBankAddComponent,
    QuestionBankDetailsComponent
  ],
  imports: [
    CommonModule,
    QuestionBankRoutingModule,
    MaterialModule

  ]
})
export class QuestionBankModule { }
