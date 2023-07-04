import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {McqComponent} from "./mcq.component";
import {McqAddComponent} from "./mcq-add/mcq-add.component";
import {ProblemSetterComponent} from "./problem-setter/problem-setter.component";

const routes: Routes = [
  {
    path:'',
    component:McqComponent
  },
  {
    path:'add',
    component:McqAddComponent
  },
  {
    path:'problem_setter',
    component:ProblemSetterComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class McqRoutingModule { }
