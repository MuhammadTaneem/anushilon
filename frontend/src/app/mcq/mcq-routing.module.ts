import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {McqComponent} from "./mcq.component";
import {McqAddComponent} from "./mcq-add/mcq-add.component";

const routes: Routes = [
  {
    path:'',
    component:McqComponent
  },
  {
    path:'add',
    component:McqAddComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class McqRoutingModule { }
