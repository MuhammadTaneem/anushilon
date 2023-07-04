from sqlalchemy import Table, Column, Integer, String, Boolean
from core.db import mapper_registry

admin_table = Table(
    "admin", mapper_registry.metadata,
    Column('id', Integer, primary_key=True),
    Column('full_name', String),
    Column('role', String),
    Column('password', String),
    Column('email', String),
    Column('active', Boolean, default=False)
)


class Admin:
    pass


admin_mapper = mapper_registry.map_imperatively(Admin, admin_table)
