import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import { MatTable } from '@angular/material/table';
import {MatPaginator, PageEvent} from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import {MCQType} from "./mcq.model";
import {McqService} from "./mcq.service";
import {from} from "rxjs";

@Component({
  selector: 'app-mcq',
  templateUrl: './mcq.component.html',
  styleUrls: ['./mcq.component.css']
})
export class McqComponent implements  OnInit {
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatTable) table!: MatTable<MCQType>;
  mcqDataList: any;
  count:number = 0;
  /** Columns displayed in the table. Columns IDs can be added, removed, or reordered. */
  displayedColumns = ['id','question','subject','chapter','published','details'];

  constructor(
    private mcqService:McqService

  ) {}

  ngOnInit() {
    this.loadMcqList();
  }




  onToggleChange(event: any,mcq:any) {
    const formData = new FormData();
    for (const key in mcq) {
      if (mcq.hasOwnProperty(key)) {
        const value = mcq[key];
        formData.append(key, value);
      }
    }
    formData.append('published',event.checked);
    formData.delete('option_img_1')
    formData.delete('option_img_2')
    formData.delete('option_img_3')
    formData.delete('option_img_4')
    formData.delete('question_img')
    formData.delete('explanation_img')
    this.mcqService.updateMcq(formData,mcq.id).subscribe({
      next: (response)=>{
        console.log(response)
      },
      error:(error)=>{
        this.loadMcqList();
        console.log(error)
      },

    })
  }


  loadMcqList(limit=25, offset =0){
    this.mcqService.getMcqList(limit,offset).subscribe({
      next: (response)=>{
        console.log(response.results);
        console.log(response.count);
        this.mcqDataList = response.results;
        this.count = response.count;
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

  onChangePage(pageData: PageEvent) {
    this.loadMcqList(pageData.pageSize,pageData.pageIndex *pageData.pageSize);

  }
}
