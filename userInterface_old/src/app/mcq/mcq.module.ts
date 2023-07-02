import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {McqRoutingModule} from './mcq-routing.module';
import {McqComponent} from './mcq.component';
import {McqAddComponent} from './mcq-add/mcq-add.component';
import {MaterialModule} from "../material/material.module";
import {MatTableModule} from "@angular/material/table";


@NgModule({
  declarations: [
    McqComponent,
    McqAddComponent
  ],
  imports: [
    CommonModule,
    McqRoutingModule,
    MaterialModule,
    MatTableModule
  ]
})
export class McqModule {
}
