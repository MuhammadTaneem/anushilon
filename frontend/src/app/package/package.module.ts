import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { PackageRoutingModule } from './package-routing.module';
import { PackageComponent } from './package.component';
import { PackageAddComponent } from './package-add/package-add.component';
import { PackageDetailsComponent } from './package-details/package-details.component';
// import {MatButtonModule} from "@angular/material/button";
// import {MatIconModule} from "@angular/material/icon";
// import {ReactiveFormsModule} from "@angular/forms";
// import {MatFormFieldModule} from "@angular/material/form-field";
// import {MatInputModule} from "@angular/material/input";
import {MaterialModule} from "../material/material.module";


@NgModule({
  declarations: [
    PackageComponent,
    PackageAddComponent,
    PackageDetailsComponent
  ],
  imports: [
    CommonModule,
    PackageRoutingModule,
    // MatButtonModule,
    // MatIconModule,
    // ReactiveFormsModule,
    // MatFormFieldModule,
    // MatInputModule,
    MaterialModule
  ]
})
export class PackageModule { }
