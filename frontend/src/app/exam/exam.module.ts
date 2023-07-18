import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ExamRoutingModule } from './exam-routing.module';
import { ExamComponent } from './exam.component';
import { ExamAddComponent } from './exam-add/exam-add.component';
import { ExamDetailsComponent } from './exam-details/exam-details.component';
import {MaterialModule} from "../material/material.module";
import {MatExpansionModule} from "@angular/material/expansion";
import {MatListModule} from "@angular/material/list";
import {FormsModule} from "@angular/forms";


@NgModule({
  declarations: [
    ExamComponent,
    ExamAddComponent,
    ExamDetailsComponent
  ],
  imports: [
    CommonModule,
    ExamRoutingModule,
    MaterialModule,
    MatExpansionModule,
    MatListModule,
    FormsModule,
  ]
})
export class ExamModule { }
