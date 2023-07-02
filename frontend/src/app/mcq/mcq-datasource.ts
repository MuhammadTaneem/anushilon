import { DataSource } from '@angular/cdk/collections';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { map } from 'rxjs/operators';
import { Observable, of as observableOf, merge } from 'rxjs';
import {MCQType} from "./mcq.model";


const EXAMPLE_DATA: MCQType[] = [
  {
    id: 1,
    question: "What is the capital of France?",
    questionImg: null,
    optionText1: "Paris",
    optionImg1: null,
    optionText2: "London",
    optionImg2: null,
    optionText3: "Berlin",
    optionImg3: null,
    optionText4: "Madrid",
    optionImg4: null,
    optionText5: "Rome",
    optionImg5: null,
    correctAns: 1,
    explanation: "Paris is the capital of France.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 2,
    question: "Who painted the Mona Lisa?",
    questionImg: null,
    optionText1: "Leonardo da Vinci",
    optionImg1: null,
    optionText2: "Pablo Picasso",
    optionImg2: null,
    optionText3: "Vincent van Gogh",
    optionImg3: null,
    optionText4: "Michelangelo",
    optionImg4: null,
    optionText5: "Salvador Dali",
    optionImg5: null,
    correctAns: 2,
    explanation: "Leonardo da Vinci painted the Mona Lisa.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 3,
    question: "What is the largest planet in our solar system?",
    questionImg: null,
    optionText1: "Jupiter",
    optionImg1: null,
    optionText2: "Saturn",
    optionImg2: null,
    optionText3: "Mars",
    optionImg3: null,
    optionText4: "Earth",
    optionImg4: null,
    optionText5: "Neptune",
    optionImg5: null,
    correctAns: 1,
    explanation: "Jupiter is the largest planet in our solar system.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 4,
    question: "Who wrote the play 'Romeo and Juliet'?",
    questionImg: null,
    optionText1: "William Shakespeare",
    optionImg1: null,
    optionText2: "Jane Austen",
    optionImg2: null,
    optionText3: "Charles Dickens",
    optionImg3: null,
    optionText4: "Mark Twain",
    optionImg4: null,
    optionText5: "Harper Lee",
    optionImg5: null,
    correctAns: 1,
    explanation: "William Shakespeare wrote the play 'Romeo and Juliet'.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 5,
    question: "Which is the largest ocean on Earth?",
    questionImg: null,
    optionText1: "Pacific Ocean",
    optionImg1: null,
    optionText2: "Atlantic Ocean",
    optionImg2: null,
    optionText3: "Indian Ocean",
    optionImg3: null,
    optionText4: "Arctic Ocean",
    optionImg4: null,
    optionText5: "Southern Ocean",
    optionImg5: null,
    correctAns: 1,
    explanation: "The Pacific Ocean is the largest ocean on Earth.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 6,
    question: "What is the chemical symbol for gold?",
    questionImg: null,
    optionText1: "Au",
    optionImg1: null,
    optionText2: "Ag",
    optionImg2: null,
    optionText3: "Fe",
    optionImg3: null,
    optionText4: "Cu",
    optionImg4: null,
    optionText5: "Pb",
    optionImg5: null,
    correctAns: 1,
    explanation: "The chemical symbol for gold is Au.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 7,
    question: "What year did the Titanic sink?",
    questionImg: null,
    optionText1: "1912",
    optionImg1: null,
    optionText2: "1905",
    optionImg2: null,
    optionText3: "1923",
    optionImg3: null,
    optionText4: "1931",
    optionImg4: null,
    optionText5: "1945",
    optionImg5: null,
    correctAns: 1,
    explanation: "The Titanic sank in the year 1912.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 8,
    question: "What is the largest organ in the human body?",
    questionImg: null,
    optionText1: "Skin",
    optionImg1: null,
    optionText2: "Heart",
    optionImg2: null,
    optionText3: "Liver",
    optionImg3: null,
    optionText4: "Brain",
    optionImg4: null,
    optionText5: "Lung",
    optionImg5: null,
    correctAns: 1,
    explanation: "The largest organ in the human body is the skin.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 9,
    question: "Which country is known as the 'Land of the Rising Sun'?",
    questionImg: null,
    optionText1: "Japan",
    optionImg1: null,
    optionText2: "China",
    optionImg2: null,
    optionText3: "India",
    optionImg3: null,
    optionText4: "South Korea",
    optionImg4: null,
    optionText5: "Thailand",
    optionImg5: null,
    correctAns: 1,
    explanation: "Japan is known as the 'Land of the Rising Sun'.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 10,
    question: "Which planet is known as the 'Red Planet'?",
    questionImg: null,
    optionText1: "Mars",
    optionImg1: null,
    optionText2: "Mercury",
    optionImg2: null,
    optionText3: "Venus",
    optionImg3: null,
    optionText4: "Jupiter",
    optionImg4: null,
    optionText5: "Saturn",
    optionImg5: null,
    correctAns: 1,
    explanation: "Mars is known as the 'Red Planet'.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 11,
    question: "What is the largest species of shark?",
    questionImg: null,
    optionText1: "Whale Shark",
    optionImg1: null,
    optionText2: "Great White Shark",
    optionImg2: null,
    optionText3: "Tiger Shark",
    optionImg3: null,
    optionText4: "Hammerhead Shark",
    optionImg4: null,
    optionText5: "Basking Shark",
    optionImg5: null,
    correctAns: 1,
    explanation: "The Whale Shark is the largest species of shark.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 12,
    question: "Who is the author of the Harry Potter book series?",
    questionImg: null,
    optionText1: "J.K. Rowling",
    optionImg1: null,
    optionText2: "Stephen King",
    optionImg2: null,
    optionText3: "George R.R. Martin",
    optionImg3: null,
    optionText4: "J.R.R. Tolkien",
    optionImg4: null,
    optionText5: "Suzanne Collins",
    optionImg5: null,
    correctAns: 1,
    explanation: "J.K. Rowling is the author of the Harry Potter book series.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 13,
    question: "What is the currency of Brazil?",
    questionImg: null,
    optionText1: "Real",
    optionImg1: null,
    optionText2: "Peso",
    optionImg2: null,
    optionText3: "Euro",
    optionImg3: null,
    optionText4: "Yen",
    optionImg4: null,
    optionText5: "Dollar",
    optionImg5: null,
    correctAns: 1,
    explanation: "The currency of Brazil is the Real.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 14,
    question: "What is the tallest mountain in the world?",
    questionImg: null,
    optionText1: "Mount Everest",
    optionImg1: null,
    optionText2: "K2",
    optionImg2: null,
    optionText3: "Kangchenjunga",
    optionImg3: null,
    optionText4: "Lhotse",
    optionImg4: null,
    optionText5: "Makalu",
    optionImg5: null,
    correctAns: 1,
    explanation: "Mount Everest is the tallest mountain in the world.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
  {
    id: 15,
    question: "Who is the current President of the United States?",
    questionImg: null,
    optionText1: "Joe Biden",
    optionImg1: null,
    optionText2: "Barack Obama",
    optionImg2: null,
    optionText3: "Donald Trump",
    optionImg3: null,
    optionText4: "George Washington",
    optionImg4: null,
    optionText5: "Abraham Lincoln",
    optionImg5: null,
    correctAns: 1,
    explanation: "Joe Biden is the current President of the United States.",
    explanationImg: null,
    subject: 1,
    chapter: 2,
    hardness: 3,
    category: 4,
    problemSetter: 1,
    published: true,
    verified: false
  },
// Add more objects here...
];

/**
 * Data source for the Mcq view. This class should
 * encapsulate all logic for fetching and manipulating the displayed data
 * (including sorting, pagination, and filtering).
 */
export class McqDataSource extends DataSource<MCQType> {
  data: MCQType[] = EXAMPLE_DATA;
  paginator: MatPaginator | undefined;
  sort: MatSort | undefined;

  constructor() {
    super();
  }

  /**
   * Connect this data source to the table. The table will only update when
   * the returned stream emits new items.
   * @returns A stream of the items to be rendered.
   */
  connect(): Observable<MCQType[]> {
    if (this.paginator && this.sort) {
      // Combine everything that affects the rendered data into one update
      // stream for the data-table to consume.
      return merge(observableOf(this.data), this.paginator.page, this.sort.sortChange)
        .pipe(map(() => {
          return this.getPagedData(this.getSortedData([...this.data ]));
        }));
    } else {
      throw Error('Please set the paginator and sort on the data source before connecting.');
    }
  }

  /**
   *  Called when the table is being destroyed. Use this function, to clean up
   * any open connections or free any held resources that were set up during connect.
   */
  disconnect(): void {}

  /**
   * Paginate the data (client-side). If you're using server-side pagination,
   * this would be replaced by requesting the appropriate data from the server.
   */
  private getPagedData(data: MCQType[]): MCQType[] {
    if (this.paginator) {
      const startIndex = this.paginator.pageIndex * this.paginator.pageSize;
      return data.splice(startIndex, this.paginator.pageSize);
    } else {
      return data;
    }
  }

  /**
   * Sort the data (client-side). If you're using server-side sorting,
   * this would be replaced by requesting the appropriate data from the server.
   */
  private getSortedData(data: MCQType[]): MCQType[] {
    if (!this.sort || !this.sort.active || this.sort.direction === '') {
      return data;
    }

    return data.sort((a, b) => {
      const isAsc = this.sort?.direction === 'asc';
      switch (this.sort?.active) {
        case 'question': return compare(a.question, b.question, isAsc);
        case 'subject': return compare(+a.subject, +b.subject, isAsc);
        case 'id': return compare(+a.id!, +b.id!, isAsc);
        case 'chapter': return compare(+a.chapter, +b.chapter, isAsc);
        case 'published': return compare(+a.published, +b.published, isAsc);
        default: return 0;
      }
    });
  }
}

/** Simple sort comparator for example ID/Name columns (for client-side sorting). */
function compare(a: string | number, b: string | number, isAsc: boolean): number {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}
