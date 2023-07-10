from datetime import datetime
from sqlalchemy import Table, Column, Integer, String, Boolean, ForeignKey, DateTime, func
from core.db import mapper_registry

mcq_table = Table(
    "mcq", mapper_registry.metadata,
    Column('id', Integer, primary_key=True),
    Column('question', String),
    Column('question_img_url', String),
    Column('option_text_1', String),
    Column('option_img_url_1', String),
    Column('option_text_2', String),
    Column('option_img_url_2', String),
    Column('option_text_3', String),
    Column('option_img_url_3', String),
    Column('option_text_4', String),
    Column('option_img_url_4', String),
    Column('correct_ans', String, nullable=False),  # Set nullable to False
    Column('explanation', String),
    Column('explanation_img', String),
    Column('hardness', String, nullable=False),  # Set nullable to False
    Column('categories', String, nullable=False),  # Set nullable to False
    Column('subject', Integer, nullable=False),  # Set nullable to False
    Column('chapter', Integer, nullable=False),  # Set nullable to False
    Column('problem_setter', ForeignKey('admin.id')),
    Column('verified', Boolean, default=False),
    Column('published', Boolean, default=False),
    Column('create_date', DateTime(timezone=True), server_default=func.now()),
    Column('last_edit', DateTime(timezone=True), onupdate=datetime.utcnow),
)



class MCQ:
    pass


mcq_mapper = mapper_registry.map_imperatively(MCQ, mcq_table)
