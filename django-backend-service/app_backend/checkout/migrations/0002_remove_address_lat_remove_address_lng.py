# Generated by Django 5.1.4 on 2024-12-09 21:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('checkout', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='address',
            name='lat',
        ),
        migrations.RemoveField(
            model_name='address',
            name='lng',
        ),
    ]
