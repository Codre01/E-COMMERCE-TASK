# Generated by Django 5.1.4 on 2024-12-09 13:39

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('lat', models.FloatField()),
                ('lng', models.FloatField()),
                ('is_default', models.BooleanField(default=False)),
                ('address', models.CharField(max_length=255)),
                ('phone', models.CharField(max_length=255)),
                ('address_type', models.CharField(choices=[('home', 'Home'), ('office', 'Office'), ('school', 'School')], default='home', max_length=10)),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Extras',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_verified', models.BooleanField(default=False)),
                ('otp', models.CharField(default='', max_length=6)),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]