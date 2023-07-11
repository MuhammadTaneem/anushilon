import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {McqComponent} from "./mcq.component";
import {McqAddComponent} from "./mcq-add/mcq-add.component";
import {authGuard} from "../auth/auth.guard";

const routes: Routes = [
  {
    path:'',
    canActivate: [authGuard],
    component:McqComponent
  },
  {
    path:'add',
    canActivate: [authGuard],
    component:McqAddComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class McqRoutingModule { }
