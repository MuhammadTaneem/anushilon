import { ComponentFixture, TestBed } from '@angular/core/testing';

import { McqAddComponent } from './mcq-add.component';

describe('McqAddComponent', () => {
  let component: McqAddComponent;
  let fixture: ComponentFixture<McqAddComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [McqAddComponent]
    });
    fixture = TestBed.createComponent(McqAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
