import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {HomepageComponent} from "./dashboard/homepage/homepage.component";
import {DashboardComponent} from "./dashboard/dashboard.component";
import {McqComponent} from "./mcq/mcq.component";
import {ExamComponent} from "./exam/exam.component";
import {OfferComponent} from "./offer/offer.component";
import {PackageComponent} from "./package/package.component";

const routes: Routes = [
  {
    path: '',
    // pathMatch: 'full',
    component: DashboardComponent,
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'homepage',
      },
      {
        path: 'homepage',
        component: HomepageComponent,

      },
      {
        path: 'mcq',
        component: McqComponent,
      },
      {
        path: 'exam',
        component: ExamComponent,
      },
      {
        path: 'offer',
        component: OfferComponent,
      },
      {
        path: 'package',
        component: PackageComponent,
      },
    ]
  },
  {
    path: 'auth',
    loadChildren: () => import('./auth/auth.module').then((m) => m.AuthModule),
    outlet: 'main'

  },


  // {path: '**', redirectTo: 'dashboard'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
