import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {authGuard} from "../auth/auth.guard";
import {McqComponent} from "../mcq/mcq.component";
import {McqAddComponent} from "../mcq/mcq-add/mcq-add.component";
import {MaqDetailsComponent} from "../mcq/mac-details/maq-details.component";
import {ExamComponent} from "./exam.component";
import {ExamAddComponent} from "./exam-add/exam-add.component";
import {ExamDetailsComponent} from "./exam-details/exam-details.component";

const routes: Routes = [
  {
    path:'',
    canActivate: [authGuard],
    component:ExamComponent
  },
  {
    path:'add',
    canActivate: [authGuard],
    component:ExamAddComponent
  },
  {
    path:'details/:id',
    canActivate: [authGuard],
    component:ExamDetailsComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ExamRoutingModule { }
