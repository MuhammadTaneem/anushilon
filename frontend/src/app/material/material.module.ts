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
  MatGridListModule
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
