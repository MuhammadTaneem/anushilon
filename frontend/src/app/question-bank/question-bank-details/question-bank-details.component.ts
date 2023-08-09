import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {QuestionBankService} from "../question-bank.service";

@Component({
  selector: 'app-question-bank-details',
  templateUrl: './question-bank-details.component.html',
  styleUrls: ['./question-bank-details.component.css']
})
export class QuestionBankDetailsComponent implements OnInit {
  questionBankDetails: any;
  loading: boolean = true;



  constructor(
    private questionBankService: QuestionBankService,
    private route: ActivatedRoute,
  ) {}


  ngOnInit() {
    this.route.params.subscribe(params => {
      this.loadQuestionBank( +params['id']);
    });

  }

  onToggleChange(event: any,key:string) {
    const formData = new FormData();
    formData.append(key,event.checked);
    this.questionBankService.updateQuestionBank(formData,this.questionBankDetails.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{

        console.log(error)
      },

    })
  }


  loadQuestionBank(id:number){
    this.questionBankService.getQuestionBank(id).subscribe({
      next: (response)=>{
        this.questionBankDetails = response;
        this.loading = false;
      },
      error: (err)=>{
        console.log(err.status_code);
        console.log(err.error);
        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete:()=>{}
    })
  }


}
