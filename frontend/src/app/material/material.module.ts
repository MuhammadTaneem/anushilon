import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {MatCardModule} from "@angular/material/card";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInputModule} from '@angular/material/input';
import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';
import {MatToolbarModule} from "@angular/material/toolbar";
import {MatTableModule} from '@angular/material/table';
import {ReactiveFormsModule} from "@angular/forms";
import {MatSlideToggleModule} from '@angular/material/slide-toggle';
import {MatGridListModule} from '@angular/material/grid-list';
import {MatSelectModule} from '@angular/material/select';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import {MatPaginatorModule} from '@angular/material/paginator';
import {MatDatepickerModule} from '@angular/material/datepicker';
import {MatNativeDateModule} from '@angular/material/core';
import {DragDropModule,
  CdkDrag,
  CdkDropList,} from '@angular/cdk/drag-drop';

import {MatStepperModule} from '@angular/material/stepper';
import {MatCheckboxModule} from '@angular/material/checkbox';
let module_list=[
  CommonModule,
  MatCardModule,
  MatFormFieldModule,
  MatInputModule,
  MatIconModule,
  MatDividerModule,
  MatButtonModule,
  MatToolbarModule,
  MatTableModule,
  ReactiveFormsModule,
  MatSlideToggleModule,
  MatGridListModule,
  MatSelectModule,
  MatSnackBarModule,
  MatPaginatorModule,
  MatDatepickerModule,
  MatNativeDateModule,
  DragDropModule,
  MatStepperModule,
  MatCheckboxModule,
  CdkDropList, CdkDrag
];

@NgModule({
  declarations: [],
  imports: [
    module_list

  ],
  exports:[
    module_list
  ]
})
export class MaterialModule { }
