import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { McqRoutingModule } from './mcq-routing.module';
import { McqComponent } from './mcq.component';
import {MaterialModule} from "../material/material.module";
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { McqAddComponent } from './mcq-add/mcq-add.component';
import { ProblemSetterComponent } from './problem-setter/problem-setter.component';


@NgModule({
  declarations: [
    McqComponent,
    McqAddComponent,
    ProblemSetterComponent
  ],
  imports: [
    CommonModule,
    McqRoutingModule,
    MaterialModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule
  ]
})
export class McqModule { }
