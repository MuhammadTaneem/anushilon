import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {authGuard} from "../auth/auth.guard";
import {PackageComponent} from "../package/package.component";
import {PackageAddComponent} from "../package/package-add/package-add.component";
import {PackageDetailsComponent} from "../package/package-details/package-details.component";
import {QuestionBankComponent} from "./question-bank.component";
import {QuestionBankAddComponent} from "./question-bank-add/question-bank-add.component";
import {QuestionBankDetailsComponent} from "./question-bank-details/question-bank-details.component";

const routes: Routes = [
  {
    path:'',
    canActivate: [authGuard],
    component:QuestionBankComponent
  },
  {
    path:'add',
    canActivate: [authGuard],
    component:QuestionBankAddComponent
  },
  {
    path:'details/:id',
    canActivate: [authGuard],
    component:QuestionBankDetailsComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class QuestionBankRoutingModule { }
