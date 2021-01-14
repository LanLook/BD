create database clinic;
use clinic;
create table breed(
	id int not null auto_increment,
    cost int not null,
    name varchar(20) not null,
    homeland varchar(50) not null,
    primary key(id));

create table owner(
	id int not null auto_increment,
    address varchar(30) not null,
    fullName varchar(50) not null,
    PhoneNumber varchar(15) not null,
    primary key(id));
    
create table treatment(
	id int not null auto_increment,
    name varchar(100) not null,
    duration time not null,
    appointmentDate date not null,
    primary key(id));
    
create table doctor(
	id int not null auto_increment,
    address varchar(30) not null,
    fullName varchar(50) not null,
    PhoneNumber varchar(15) not null,
    primary key(id));
    
create table clinicServices(
	id int not null auto_increment,
    name varchar(30) not null,
    cost int not null,
    dateTime datetime not null,
    primary key(id));
    
create table symptoms(
	id int not null auto_increment,
    description text not null,
    primary key(id));
    
create table drug(
	id int not null auto_increment,
    name varchar(30) not null,
    cost int not null,
    dischangeDate date not null,
    primary key(id));
    
create table dog(
	id int not null auto_increment,
    sex bool not null,
    nickname varchar(20) not null,
    age varchar(3) not null,
    breed_id int not null,
    owner_id int not null,
    primary key(id),
    foreign key(breed_id) references breed(id),
    foreign key(owner_id) references owner(id));
    
create table diagnosis(
	id int not null auto_increment,
    name varchar(50) not null,
	date date not null,
    treatment_id int not null,
    primary key(id),
    foreign key(treatment_id) references treatment(id));
    
create table treatment_drug(
    treatment_id int not null,
    drug_id int not null,
    primary key (treatment_id, drug_id),
    foreign key (treatment_id) references treatment (id),
    foreign key (drug_id) references drug (id));
    
create table clinicservices_doctor(
    clinicservices_id int not null,
    doctor_id int not null,
    primary key (clinicservices_id, doctor_id),
    foreign key (clinicservices_id) references clinicservices (id),
    foreign key (doctor_id) references doctor (id));
    
create table reception(
	id int not null auto_increment,
    registration varchar(100) not null,
    date date not null,
    doctor_id int not null,
    dog_id int not null,
    primary key(id),
    foreign key(doctor_id) references doctor(id),
    foreign key(dog_id) references dog(id));
    
create table reception_clinicservices(
    reception_id int not null,
    clinicservices_id int not null,
    primary key (reception_id, clinicservices_id),
	foreign key (reception_id) references reception (id),
    foreign key (clinicservices_id) references clinicservices (id));
    
create table reception_symptoms(
    reception_id int not null,
    symptoms_id int not null,
    primary key (reception_id, symptoms_id),
	foreign key (reception_id) references reception (id),
    foreign key (symptoms_id) references symptoms (id));

create table symptoms_diagnosis(
	symptoms_id int not null,
    diagnosis_id int not null,
    primary key (diagnosis_id, symptoms_id),
	foreign key (symptoms_id) references symptoms (id),
    foreign key (diagnosis_id) references diagnosis (id));


select dog.nickname as dog, owner.fullname as owner 
from dog
join owner on owner.id = dog.owner_id;

select distinct name from clinicservices;

select nickname, age from dog;

select* from doctor;

select* from owner;

select avg(cost) from clinicservices;

select avg(cost) from drug;

select avg(duration) from treatment;

select name from drug;

select nickname from dog;

select distinct description from symptoms;

select distinct homeland from breed;

select dog.nickname as dog, owner.fullname as owner 
from dog
join owner on owner.id = dog.owner_id;

select distinct nickname from dog;

select*
from reception where id = 3;

select doctor.fullname as doctor, clinicservices.name as clinicservices
from clinicservices
join clinicservices_doctor on clinicservices_doctor.clinicservices_id = clinicservices.id
join doctor on doctor.id = clinicservices_doctor.doctor_id;

select clinicservices.name, clinicservices.cost, count(cost) 
from clinicservices group by cost;

#какие самые популярные услуги клиники
select clinicservices.name as clinicservices, count(reception_clinicservices.clinicservices_id) as reception_clinicservices
from reception_clinicservices 
join clinicservices on clinicservices.id = reception_clinicservices.clinicservices_id
group by clinicservices_id;

#какие самые популярные лекарства
select drug.name as drug, count(treatment_drug.drug_id) as reception_clinicservicestreatment_drug
from treatment_drug 
join drug on drug.id = treatment_drug.drug_id
group by drug_id;

delete from symptoms where id = '12';
delete from symptoms where id = '13';
delete from symptoms where id = '14';
delete from symptoms where id = '15';
delete from symptoms where id = '16';
delete from symptoms where id = '17';

select age, nickname from dog
where age >= '10';

select appointmentDate, name from treatment
where appointmentDate < '2020-11-01';

select name, cost, dateTime from clinicservices
where dateTime <= '2020-11-09 14:00:00' and cost < '500';

select nickname, age from dog
where age <= '3' and owner_id = '1';

select registration, date from reception
where date = '2020-11-09' or date = '2020-11-07';

select nickname from dog
where owner_id = '2' or owner_id = '1';

select name, homeland from breed
where homeland = 'USA' or homeland = 'Canada';

select name, homeland from breed
where homeland not like 'England';

select name, cost from breed
where cost > '20000' and cost < '40000';

select name, cost from breed
where cost between  '20000' and '40000';

select nickname from dog
where nickname not like 'R%';

select * from breed
where cost in ('30000', '40000');

select * from owner
where id in ('1','2','3');

select fullname, PhoneNumber from owner
where phonenumber in ('658455', '861610');

select name, duration from treatment
where duration between '240:00:00' and '480:00:00';

select name, cost from drug
where cost between '150' and '500';

select fullname from doctor
where phonenumber is null;

select fullname as 'Полное имя', address as 'Адрес', phonenumber as 'Телефонный номер' from doctor;
select nickname as 'Кличка', age as 'Возраст' from dog;
select name as 'Наименование', appointmentDate as 'Дата назначения' from treatment;

select name from breed
where cost >= all
	(select cost from breed
    where homeland = 'England');

create table owner_fullname_PhoneNumber (
	fullname_copy varchar(100) not null,
    PhoneNumber_copy varchar(15) not null);

insert into owner_fullname_PhoneNumber (fullname_copy, PhoneNumber_copy)
select fullname, PhoneNumber from owner;

delete from owner_fullname_phonenumber where fullname_copy != '10';

create table owner_dog (
	nickname_copy varchar(50) not null,
    fullname_copy varchar(100) not null);

insert into owner_dog (nickname_copy, fullname_copy)
select dog.nickname as dog, owner.fullname as owner
from dog
join owner on owner.id = dog.owner_id
order by owner.id;


select distinct name from drug
where name like 'Р%';

select name from breed
where name like 'B%';

select fullname from owner
where fullname like 'Chris%';

select fullname from doctor
where fullname like 'доктор С%';

select distinct name, cost from drug
where cost like '%0';

select count(nickname) from dog;
select count(fullname) from owner;

select max(cost) from drug;
select max(duration) from treatment;
select min(cost) from breed;
select min(age) from dog;
select sum(cost) from clinicservices;
select sum(age) from dog;
select avg(cost) from breed;

select name, count(cost) from clinicservices
group by name;

select owner_id, count(owner_id) from dog
group by owner_id;

select homeland, count(homeland) from breed
group by homeland;

select name, count(name) from drug
group by name;

select name, avg(cost) from drug
group by name
having avg(cost) >= '200';

select name, avg(duration) from treatment
group by name
having count(name) >= '2';

select doctor_id, count(doctor_id) from reception
group by doctor_id
having count(doctor_id) >= '2';

select nickname, age from dog
order by age;

select* from doctor
order by fullname;

select* from owner
order by fullname desc;

select name, cost from drug
order by cost desc;

select name from diagnosis
order by name;

select name, cost from breed
order by cost desc;

select name, cost from breed
order by name;

select name, cost into @name, @cost 
from breed
where cost <= '15000';
select @name, @cost;

select fullname, address into @name, @address 
from owner
where address like 'D 28';
select @name, @address;

#Вывести самую дорогую породу, выведенную в Англии
select name from breed
where cost >= all
	(select cost from breed
    where homeland = 'England');
    
#Вывести дату назначения самой дешевой глюкозы
select dischargeDate from drug
where cost<= all
	(select cost from drug
    where name = 'глюкоза');

select fullname, address, PhoneNumber from owner
union select fullname, address, PhoneNumber from doctor;

select fullname, address, PhoneNumber from doctor
where
	exists (select fullname, address, PhoneNumber from owner
		where doctor.fullname = owner.fullname
        and doctor.address = owner.address
        and doctor.PhoneNumber = owner.PhoneNumber);

select theater.name as theater, cinemahall.hall_number as hall_number, cinemahall.capacity as capacity from theater
join cinemahall on cinemahall.theater_id = theater.id
order by theater.name;

select doctor.fullname as name, reception.doctor_id from doctor
left join reception on reception.doctor_id = doctor.id
group by doctor.id
having count(reception.doctor_id) >= 3
order by doctor.fullname;

select dog.nickname as name, count(reception.dog_id) as count from dog
join reception on reception.dog_id = dog.id
group by dog.id
order by dog.nickname;

select owner.fullname as fullname, count(owner.fullname) as count from dog
join reception on reception.dog_id = dog.id
join owner on owner.id = dog.owner_id
group by owner.id
order by owner.fullname;

#Самые популярные симптомы
select symptoms.description, count(symptoms.description) as count from symptoms
join reception_symptoms on reception_symptoms.symptoms_id = symptoms.id
join reception on reception.id = reception_symptoms.reception_id
group by symptoms.description
order by count(symptoms.description) desc;

#Самые популярные диагнозы
select diagnosis.name, count(diagnosis.name) as count from diagnosis
join symptoms_diagnosis on symptoms_diagnosis.diagnosis_id = diagnosis.id
join symptoms on symptoms.id = symptoms_diagnosis.symptoms_id
join reception_symptoms on reception_symptoms.symptoms_id = symptoms.id
join reception on reception.id = reception_symptoms.reception_id
group by diagnosis.name
order by count(diagnosis.name) desc;

#Вывести всех врачей и какие услуги они пердоставляют
select doctor.fullname as doctor, clinicservices.name as clinicservices
from clinicservices
join clinicservices_doctor on clinicservices_doctor.clinicservices_id = clinicservices.id
right join doctor on doctor.id = clinicservices_doctor.doctor_id;


#Вывести всех владельцев и их собак 
select dog.nickname as dog, owner.fullname as owner from dog
right join owner on owner.id = dog.owner_id;

#Вывести все услуги и приемы, на которых они были назначены
select clinicservices.name, reception.registration as registration from clinicservices
left join reception_clinicservices on reception_clinicservices.clinicservices_id = clinicservices.id
join reception on reception.id = reception_clinicservices.reception_id;

select nickname, age from dog
limit 3;

select name, cost from drug
where cost < 500
order by cost
limit 5;

select * from doctor
limit 5, 3;

#Вывести все лекарства для данного лечения
select treatment.name as treatment, drug.name as drug, drug.cost
from drug
join treatment_drug on treatment_drug.drug_id = drug.id
join treatment on treatment.id = treatment_drug.treatment_id
order by treatment.name;

#Вывести историю владельца (ФИО, адрес, телефон):Собака (порода, возраст), дата посещения, к какому доктору, услуги
select owner.fullName, owner.address, owner.PhoneNumber, dog.nickname, dog.age as age, breed.name as breed, 
reception.registration as registration, reception.date as date, 
doctor.fullName, clinicservices.name
from reception
join doctor on doctor.id = reception.doctor_id
join dog on dog.id = reception.dog_id
join reception_clinicservices on reception_clinicservices.reception_id = reception.id
join clinicservices on clinicservices.id = reception_clinicservices.clinicservices_id
join breed on breed.id = dog.breed_id
join owner on owner.id = dog.owner_id;


#За заданный период времени вывести все симптомы, с которыми обращались породы (порода, симптом)
select dog.nickname, breed.name, symptoms.description, reception.date from breed
join dog on dog.breed_id = breed.id
join reception on reception.dog_id = dog.id
join reception_symptoms on reception_symptoms.reception_id = reception.id
join symptoms on symptoms.id = reception_symptoms.symptoms_id
where date between '2020-10-01' and '2020-10-31'
order by date;


#Для владельца и собаки посчитать, сколько вышла стоимость посещения (по услугам)
select owner.fullname, dog.nickname, round(sum(clinicservices.cost)) from dog
join owner on owner.id = dog.owner_id
join reception on dog_id = dog.id
join reception_clinicservices on reception_clinicservices.reception_id = reception.id
join clinicservices on clinicservices.id = reception_clinicservices.clinicservices_id
group by dog.nickname; 

INSERT INTO `owner` (`address`,`fullname`,`phonenumber`) VALUES ("Ap #911-9347 Orci. Road","Tiger Odonnell","483580"),("3714 Metus Rd.","Martena Cole","507143"),("538-9058 Ac St.","Carlos Chavez","616135"),("830-3019 Mi Street","Kameko Cross","463600"),("Ap #439-400 Vivamus Rd.","Quinn Albert","530329"),("236 Ipsum Avenue","Gregory Santana","955830"),("P.O. Box 977, 2880 Semper St.","Lucian Whitaker","995518"),("Ap #176-9428 Risus. Street","Dominique Mercado","145671"),("8350 Aenean St.","Rashad Acevedo","690522"),("8196 Enim Av.","Dalton Gates","357292"),("8371 Diam Av.","Coby Chaney","570072"),("Ap #219-6555 Non Rd.","Arsenio Howard","364921"),("P.O. Box 403, 7424 Feugiat. Av.","Laith Weaver","361595"),("435-392 Lacus. Av.","Veda Buckley","506814"),("P.O. Box 205, 4286 Nullam Av.","Grace Madden","865634"),("P.O. Box 460, 7992 Cum Road","Kevin Fowler","647447"),("718-8649 Quis Ave","Davis Waller","441527"),("P.O. Box 376, 4323 Eu, St.","Kirestin Higgins","331943"),("199-3239 Justo. Street","Denise Bonner","171049"),("2211 Condimentum. St.","Kirk Todd","882180"),("778-4349 Nulla St.","Iola Lindsay","817740"),("Ap #636-9682 Quis, Av.","Sophia Rodgers","720968"),("P.O. Box 116, 7771 Risus. Road","Bell Patel","408360"),("806-1312 Sociosqu Ave","Callum Downs","963295"),("117-6420 Nulla Avenue","Jasper Hill","165064"),("P.O. Box 865, 7517 Aliquam St.","MacKensie Newman","664775"),("219-7279 Sem Rd.","Jesse Kirkland","136794"),("Ap #750-1373 Sapien St.","Benjamin Alford","611917"),("1348 Mauris Rd.","Hayden Barker","550216"),("830-9108 Bibendum Rd.","Phillip Garner","766849"),("Ap #703-1894 Suspendisse Street","Rama Garcia","479751"),("Ap #249-4023 Iaculis, Rd.","Yoko Dyer","340344"),("Ap #727-1187 Vivamus Ave","Yen Bright","945574"),("264-5335 Donec Ave","Imogene Hatfield","986143"),("P.O. Box 470, 7773 Eros. Av.","Brent Tyler","927405"),("212 Suspendisse Ave","Howard Fernandez","574364"),("880-8479 Ligula. St.","Ramona Finley","786609"),("Ap #722-4674 Nascetur Avenue","Tad Rutledge","465972"),("P.O. Box 357, 4700 Sed Road","Shad Cummings","991749"),("P.O. Box 874, 1217 Nibh Road","Dillon Higgins","282902"),("197-5158 Dolor Rd.","Bernard Peterson","710897"),("639-5390 Adipiscing Road","Jarrod Bishop","270934"),("P.O. Box 443, 6435 Nisi. Rd.","Kadeem Richard","354597"),("5895 Non Ave","Meredith Salinas","582903"),("1137 Lacus, Ave","Slade Goff","506215"),("907-6791 Cursus. Avenue","Raja Boyer","612867"),("709-8633 Et Rd.","Zena Conrad","223830"),("P.O. Box 163, 4462 Vehicula. St.","Gregory Stafford","894091"),("P.O. Box 114, 434 Posuere Av.","Valentine Le","704277"),("1161 Et Avenue","Octavia Leon","161035"),("P.O. Box 746, 5878 Nibh Av.","Nicole Dennis","641136"),("635-6449 Sapien. St.","Slade Rasmussen","173099"),("8876 Nec St.","Kiayada Wells","772639"),("Ap #931-1793 Erat, Road","Anastasia Heath","937570"),("Ap #269-1251 Dolor Rd.","Kessie Reese","255914"),("4259 Cum Road","Neve Kinney","855758"),("P.O. Box 983, 4277 Mi Road","Lynn Branch","874341"),("3766 Imperdiet Avenue","Lavinia Avery","454277"),("6046 Urna. Ave","Rebecca James","710797"),("P.O. Box 189, 9265 Nam Ave","Amity Jefferson","493237"),("792-2195 Vel, Avenue","Zane Dillon","898826"),("5338 Hendrerit St.","Joel Garrett","751851"),("P.O. Box 893, 7266 In Road","Adena Ratliff","689256"),("Ap #586-1744 Vel Avenue","Hu Gilbert","501673"),("Ap #740-7262 Nostra, St.","Hilel Long","283543"),("P.O. Box 305, 7648 Tempus Avenue","Noble Sharpe","708906"),("905-5788 Faucibus Ave","Garrison Simmons","852598"),("9311 Velit Ave","Abdul Rodgers","795359"),("Ap #315-8446 Mattis Avenue","Montana Calderon","195221"),("513-8992 Senectus Rd.","Carl Waters","130622"),("P.O. Box 891, 9754 Venenatis Av.","Keefe Strickland","701103"),("827-7176 Euismod Street","Yoshi Navarro","861784"),("P.O. Box 460, 1344 Ornare, Ave","Fritz Rose","578373"),("P.O. Box 194, 3363 Dictum St.","Martin Morton","374187"),("296-8721 Et, St.","Cherokee Hale","753102"),("Ap #131-7751 In Rd.","Nichole Wright","524900"),("368-7103 In Ave","Bruno Harper","567463"),("Ap #527-7784 Penatibus Rd.","Rhonda Wheeler","555608"),("P.O. Box 766, 580 Sit Rd.","Sigourney Ellison","891380"),("P.O. Box 487, 2903 Nulla Road","Carter Bishop","596406"),("274-7393 Varius. Rd.","Phoebe Wiggins","356622"),("P.O. Box 162, 7562 Arcu. St.","Jenna Tran","962495"),("P.O. Box 818, 5852 Egestas Road","Haley Morales","904878"),("P.O. Box 652, 1617 Laoreet Street","Nita Davenport","459703"),("216-1899 Proin Street","Maxine Holloway","383637"),("7618 Malesuada Street","Hunter Murray","769900"),("P.O. Box 312, 8600 In Rd.","Isaac Fitzpatrick","771145"),("715-8138 Gravida Street","Howard Kane","158269"),("P.O. Box 186, 4688 Diam Road","Kaden Walter","832144"),("7602 Primis Avenue","Mia Mcdowell","367762"),("Ap #610-6332 Orci. Road","Jasper Williamson","666906"),("Ap #736-4181 Vel Street","Catherine Conley","723820"),("772-9026 Nulla Avenue","Kenyon Travis","500627"),("646-5856 Nec Street","Hadley Frazier","463106"),("Ap #904-9442 Turpis St.","Nehru Lindsay","319656"),("459-7128 Elementum, Rd.","Orli Holland","694586"),("P.O. Box 561, 7772 Suspendisse St.","Yetta Hoffman","747093"),("P.O. Box 728, 7492 Faucibus Av.","Farrah Hahn","969895"),("P.O. Box 148, 8833 In, St.","Macey Mercer","934962"),("4312 Fringilla Ave","Myles Weaver","941178");

INSERT INTO `dog` (`sex`,`nickname`,`age`,`breed_id`,`owner_id`) VALUES (0,"Cora",5,7,131),(1,"Benedict",5,10,145),(0,"Xenos",3,5,171),(1,"Kibo",3,10,205),(1,"Felicia",10,2,167),(1,"Vernon",8,6,193),(0,"Shannon",12,8,200),(1,"Cassady",6,2,195),(1,"Maia",11,4,205),(1,"Gavin",6,2,172),(1,"Jason",13,3,167),(0,"Georgia",3,1,118),(1,"Alexandra",8,11,177),(1,"Pamela",13,9,174),(1,"Alvin",9,1,145),(1,"Jarrod",14,10,211),(1,"Nayda",1,6,142),(0,"Declan",9,7,149),(1,"Yvonne",11,7,207),(0,"Micah",13,10,200),(1,"Gregory",9,11,157),(0,"Noble",5,8,130),(0,"Alexa",11,9,206),(1,"Elton",2,3,118),(1,"Sopoline",4,8,130),(1,"Clayton",8,7,148),(1,"Erin",6,6,189),(0,"Daniel",6,4,165),(1,"Aspen",15,8,168),(1,"Chanda",15,8,179),(0,"Alika",1,1,203),(0,"Lester",2,6,168),(1,"Macon",13,8,162),(0,"Juliet",4,11,198),(1,"Kiayada",9,11,192),(1,"Kato",8,4,192),(1,"Maryam",13,5,206),(0,"Nelle",1,11,161),(1,"Lane",9,4,138),(1,"Gary",12,5,169),(1,"Ryan",4,5,115),(0,"Molly",2,5,212),(0,"Shaeleigh",9,8,116),(0,"Matthew",10,5,132),(0,"Bert",10,2,171),(0,"Kermit",10,8,193),(0,"Dai",4,4,142),(0,"Cody",11,3,187),(0,"Melvin",13,6,115),(0,"Hall",13,6,141),(1,"Cassidy",11,5,127),(1,"Leila",2,4,153),(0,"Kiayada",13,10,211),(1,"Driscoll",14,1,165),(1,"Madison",2,5,135),(0,"Maite",4,1,134),(1,"Kelly",5,3,140),(1,"Dara",14,2,121),(0,"Xaviera",12,4,194),(1,"Seth",3,7,202),(1,"Alexander",13,5,131),(0,"Hadassah",4,5,142),(0,"Haviva",1,7,195),(1,"Larissa",4,5,118),(1,"Hyacinth",12,5,202),(0,"Hollee",5,9,187),(0,"Clayton",8,4,122),(0,"Emmanuel",2,10,113),(1,"Holmes",9,2,195),(1,"Naida",11,7,192),(1,"Kaye",5,4,113),(0,"Avram",5,5,198),(0,"Gareth",1,7,123),(0,"Arthur",13,9,159),(1,"Lars",7,7,210),(0,"Judah",5,7,152),(0,"Sarah",9,7,182),(0,"Ruth",12,11,119),(1,"Lev",4,5,186),(0,"Beatrice",3,5,202),(0,"Martena",3,4,157),(1,"Chava",8,10,156),(1,"Colin",4,3,119),(0,"Marvin",13,4,116),(0,"Tashya",2,10,184),(1,"Quentin",5,2,115),(0,"Quyn",3,11,156),(0,"Marsden",10,9,186),(0,"Herrod",13,2,163),(1,"Aidan",8,2,180),(0,"Josephine",10,10,180),(1,"Harlan",5,3,185),(1,"Jessica",13,10,184),(0,"Gabriel",11,2,123),(0,"Genevieve",7,10,181),(0,"Randall",13,1,175),(1,"Giacomo",4,2,181),(0,"Tad",7,9,151),(0,"Sopoline",11,8,120),(0,"Armand",5,3,209);

INSERT INTO `doctor` (`address`,`fullname`,`phonenumber`) VALUES ("6572 Nulla St.","Roth Cantu","124126"),("712-3676 Egestas Av.","Brianna Grant","689683"),("6592 Libero. Rd.","Eleanor Moon","897952"),("Ap #850-2908 Etiam St.","Buffy Marquez","515439"),("P.O. Box 442, 3058 Libero. Avenue","Chancellor Campos","318461"),("4207 Lacus. St.","Ronan Burch","334049"),("1606 Mattis Avenue","Travis Brown","810820"),("167-7258 Facilisis Av.","Tashya Salazar","733268"),("2561 Suspendisse Rd.","Octavius Chen","391068"),("Ap #107-6106 Duis Street","Mariam Rutledge","649922"),("385-9656 Inceptos St.","Ignacia Figueroa","671663"),("232 Cras Av.","Moses Davenport","840686"),("1364 Arcu. Av.","Dominique Morrow","517833"),("908-498 Vitae Road","Louis Day","179888"),("494-3435 Ut, Avenue","Aladdin Callahan","717543"),("Ap #324-6041 Risus Rd.","Elijah Woodward","551898"),("362-3615 Nec, Avenue","Diana Bailey","143518"),("P.O. Box 401, 7861 Vel, Av.","Melvin Neal","695737"),("8983 Elit, St.","Wylie Bonner","812768"),("P.O. Box 615, 9027 Non, Rd.","Lee Quinn","599386"),("868-6417 Ornare St.","Joelle Hinton","847918"),("P.O. Box 234, 8075 Enim Ave","Leonard Cooke","878006"),("Ap #978-9190 Montes, Street","Flavia Goodman","571529"),("527-2418 Suspendisse Street","Daquan Woods","587473"),("5331 Integer Rd.","Scott King","340298"),("P.O. Box 410, 8944 Curabitur Rd.","Colby Mcbride","217974"),("8558 Vivamus Road","Perry Buchanan","217202"),("227-4467 Pellentesque Street","Benjamin York","696456"),("995-3718 Massa St.","Urielle Levy","719198"),("748-7793 Porttitor St.","Caleb Tate","139688"),("Ap #842-1911 Blandit Ave","Dai Lott","275483"),("5348 Iaculis, Rd.","Uriah Mercer","895560"),("596-2763 Lectus. Rd.","Lucas Brock","507307"),("Ap #208-2226 Ante. Rd.","Kylynn Tillman","778955"),("Ap #993-5251 Amet Street","Clarke Byers","344608"),("P.O. Box 389, 2544 Pede, Rd.","Hedley Emerson","250060"),("4455 Parturient Rd.","Upton Wall","379753"),("P.O. Box 609, 1014 Ultrices. Ave","Lael Whitaker","282598"),("855 Quisque Road","Andrew Myers","393071"),("P.O. Box 902, 3663 Pretium Rd.","Sloane Levy","548386"),("P.O. Box 288, 8141 A, Road","Hermione Justice","599572"),("P.O. Box 888, 7518 Venenatis Av.","Ethan Hubbard","500417"),("Ap #832-3486 Nullam Rd.","Tobias Mcguire","196360"),("Ap #536-3617 Eu, Ave","MacKensie Mcdonald","192410"),("2438 Libero. Rd.","Indira Kline","191476"),("Ap #748-103 Ipsum. St.","Keefe Fleming","614445"),("524-3568 Donec Road","Myra Collins","243685"),("158-1262 Justo St.","Ciaran Robles","190127"),("5695 Ornare. Rd.","Quyn Malone","792891"),("Ap #817-1877 Et St.","Hermione Levy","400397"),("722-5982 Et Av.","Idona Nolan","859754"),("Ap #772-2473 Amet, Street","Farrah Preston","844335"),("P.O. Box 296, 291 Et Rd.","Alexis Guthrie","444246"),("P.O. Box 250, 246 Mauris Avenue","Glenna Battle","372366"),("515-8530 Id, St.","Regina Maynard","162563"),("P.O. Box 506, 9347 Convallis Road","Amanda Mcmillan","297255"),("P.O. Box 565, 690 Cras Street","Kasper Gilliam","129729"),("2842 Ac Av.","Paula Meyer","742443"),("9310 Vitae Street","Jeanette Harding","638663"),("8682 Neque. St.","Kelly Harris","607466"),("5649 Quam. Rd.","Rahim Hood","662936"),("P.O. Box 318, 922 Imperdiet Rd.","Rebekah Sweet","500658"),("314-5509 Cursus Road","Jin Meyer","474371"),("Ap #777-4061 Euismod Avenue","Justine Snow","841479"),("P.O. Box 732, 3092 Odio. Rd.","Kylynn Clark","990043"),("618 Eu, Rd.","Kamal Wells","656892"),("P.O. Box 596, 6038 Elit. Ave","Jasmine Daniel","421314"),("Ap #497-2603 Tempor Av.","Kirestin Wooten","683732"),("229-2187 Ligula Road","Nehru Franklin","455819"),("Ap #735-786 Placerat. St.","Alexandra Charles","136121"),("9321 Phasellus Ave","Carl Key","329013"),("P.O. Box 995, 4764 Gravida. Ave","Nerea Norris","919908"),("390-6839 Litora Ave","Oscar Phillips","642529"),("5443 Montes, Street","Judith Pierce","733048"),("Ap #539-1720 Mi Road","Lavinia Mejia","731352"),("175-7285 Vulputate, Rd.","Amelia Logan","261085"),("P.O. Box 137, 7058 Sodales. St.","Kasper Ewing","231209"),("Ap #356-1419 Pharetra, Rd.","Clayton Aguirre","548801"),("Ap #776-7265 Quisque St.","Cleo Gould","294747"),("Ap #685-4581 Ante Road","Cassandra Valentine","532015"),("P.O. Box 951, 2406 Vitae Rd.","Yardley Serrano","943169"),("9557 Feugiat Street","Ivor Mullen","552134"),("P.O. Box 847, 9732 Nec St.","Sade Reed","995575"),("300-5781 Praesent Street","Jackson Soto","280000"),("535-5711 Turpis Street","Kristen Edwards","772897"),("P.O. Box 701, 9068 Rhoncus. Road","Yen Webb","733819"),("246 Tellus St.","Serina Crosby","513892"),("534-5446 Netus St.","Justin Good","604917"),("Ap #647-5746 Ac Street","Hop Franks","181202"),("Ap #960-6212 Vestibulum St.","Sigourney Pickett","301940"),("P.O. Box 203, 1348 Convallis St.","Bernard Fleming","507019"),("P.O. Box 144, 9820 Aliquam Road","Declan Chase","343862"),("1912 Velit Av.","Chadwick Haney","130654"),("Ap #617-8637 Ante. St.","Emerson Castro","355403"),("P.O. Box 219, 3477 Tellus Rd.","Kareem House","360932"),("4359 Erat. Av.","Akeem Potter","643018"),("P.O. Box 776, 8609 Dui. St.","Hakeem Haley","284663"),("2506 Luctus St.","Heather Frank","980452"),("Ap #467-3913 Mi Road","Adele Clemons","576788"),("Ap #490-2905 Amet St.","Amy York","801631");

#Вывести собак с кличкой Kelly
#create unique index index_unique_dog_nickname on dog(nickname);
create index index_dog_nickname on dog(nickname);
explain select * from dog
where nickname = 'Kelly';

#Вывести клички собак, породы которых стоят 50000
create index index_breed_cost on breed(cost);
explain select nickname, name, cost from breed
join dog on dog.breed_id = breed.id
where cost = '25000';

#Вывести все породы, выведенные с Северной Америке
create index index_breed_homeland on breed(homeland);
explain select name, homeland from breed
where homeland = 'USA' or homeland = 'Canada';

#Вывести хозяев, у которых больше 2-х собак
create index index_owner_fullName on owner(fullName);
create index index_dog_owner_id on dog(owner_id);
explain select dog.nickname as dog, owner.fullname as owner from dog
join owner on owner.id = dog.owner_id
group by fullName
having count(fullName) >= '3';

select doctor.fullName, clinicservices.name from clinicservices
join clinicservices_doctor on clinicservices_doctor.clinicservices_id = clinicservices.id
join doctor on doctor.id = clinicservices_doctor.doctor_id
group by fullname
having count(name) >= '2';

select name, avg(cost) from drug
group by name
having avg(cost) >= '200';

#Вывести диагнозы, продолжительность лечения которых состаявляет месяц
create index index_duration_treatment on treatment(duration);
#explain 
select diagnosis.name, treatment.duration from treatment
join diagnosis on diagnosis.treatment_id = treatment.id
where duration = '240:00:00';

#Вывести записи о приеме сделанные вчера 
create index index_date_reception on reception(date);
select registration, date from reception
where date < '2020-11-09' and date > '2020-11-07';

#Вывести лечение, произведенное 7 октября
create index index_appointmentDate_treatment on treatment(appointmentDate);
select appointmentDate, name from treatment
where appointmentDate = '2020-11-07';

delimiter $$
create procedure GetOwnerForDog (in dog_name varchar(100))
begin
	select fullname, nickname
    from dog
    join owner on owner.id = dog.owner_id
    where nickname = dog_name;
end $$
delimiter ;

drop procedure GetOwnerForDog;
call GetOwnerForDog ('Bo');
call GetOwnerForDog ('Miky');

#Процедура, выводящая клички собак выбранной породы
delimiter $$
create procedure GetDogFromBreed (in breed_name varchar(100))
begin
	select nickname, name from breed
	join dog on dog.breed_id = breed.id
	where name = breed_name;
end $$
delimiter ;

call GetDogFromBreed ('Korgi');
call GetDogFromBreed ('Husky');


#Процедура, выводящая все лекарства для данного лечения
delimiter $$
create procedure GetTreatmentForDrug (in treatment_name varchar(100))
begin
	select treatment.name as treatment, drug.name as drug, drug.cost
	from drug
	join treatment_drug on treatment_drug.drug_id = drug.id
	join treatment on treatment.id = treatment_drug.treatment_id
	where treatment.name = treatment_name;
end $$
delimiter ;

call GetTreatmentForDrug ('Korgi');
call GetTreatmentForDrug ('Husky');


#Процедура, выводящая врачей и какие услуги они пердоставляют
delimiter $$
create procedure GetClinicservicesForDoctor (in doctor_name varchar(100))
begin
	select doctor.fullname as doctor, clinicservices.name as clinicservices
	from clinicservices
	join clinicservices_doctor on clinicservices_doctor.clinicservices_id = clinicservices.id
	right join doctor on doctor.id = clinicservices_doctor.doctor_id
	where doctor.fullname = doctor_name;
end $$
delimiter ;

call GetClinicservicesForDoctor ('Доктор Хаус');
call GetClinicservicesForDoctor ('Доктор Кто');


#Функция, оценивающая стоимость породы
delimiter $$
create function GetRatingBreed (count int)
returns varchar(20)
deterministic
begin
	declare rating varchar(20);
	if count <= '25000'
		then set rating = 'Низкая';
		else 
        if count <= '40000'
			then set rating = 'Средняя';
			else set rating = 'Высокая';
		end if; 
    end if;
    return rating;
end $$
delimiter ;

drop function GerRatingBreed;
select GetRatingBreed ('88558');
select GetRatingBreed ('500');


#Функция, оценивающая стоимость породы
delimiter $$
create function GetRatingBreedByName (name_breed varchar(20))
returns varchar(20)
deterministic
begin
	declare res varchar(20);
	select GetRatingBreed (breed.cost) into res from breed
    where breed.name = name_breed;    
    return res;
end $$
delimiter ;

select GetRatingBreedByName ('Korgi');
select GetRatingBreedByName ('Boxer');


#Функция, выводящая все симптомы, с которыми обращалась порода
delimiter $$
create function GetSymptomsForBreed (name_breed varchar(20))
returns varchar(20)
deterministic
begin
	select breed.name, symptoms.description from breed
	join dog on dog.breed_id = breed.id
	join reception on reception.dog_id = dog.id
	join reception_symptoms on reception_symptoms.reception_id = reception.id
	join symptoms on symptoms.id = reception_symptoms.symptoms_id
	where breed.name = name_breed;
end $$
delimiter ;

drop function GetSymptomsForBreed;
select name, GetSymptomsForBreed('Korgi') from breed;

#Функция, рассчитывающая количество собак у владельца
delimiter $$
create function CountDogs (owner_name varchar(50))
returns smallint
deterministic
begin
	declare countDog smallint;
	select count(dog.nickname) into countDog from dog
	join owner on owner.id = dog.owner_id
    where owner_name = owner.fullname;
    return countDog;
end $$
delimiter ;

drop function CountDogs;

select fullName, CountDogs(fullname) from owner
where fullname = 'Tom Holland';


#Функция, определяющая, на каком континенте была выведена порода
delimiter $$
create function GetHomelandOfBreed (breed_name varchar(20))
returns varchar(20)
deterministic
begin
	declare continent varchar(20);
	declare hl varchar(20);
    select homeland into hl from breed
	where homeland = breed_name;
    if hl = 'USA' or hl = 'Canada'
		then set continent = 'Северная Америка';
	else set continent = 'Европа';
    end if;
    return continent;
end $$
delimiter ;

drop function GetHomelandOfBreed;

select name, GetHomelandOfBreed(name) from breed;

select homeland from breed
where homeland = breed_name;
select* from breed;









#Представление, хранящее диагноз, лечение к нему и продолжительность
create view view_treatment as
	select diagnosis.name as "Диагноз", treatment.name as "Лечение", treatment.duration as "Продолжительность"
    from diagnosis
    join treatment on treatment.id = diagnosis.treatment_id;

select * from view_treatment;


#Представление, хранящее историю владельца
create view view_owner as	
    select owner.fullName as "ФИО владельца", owner.PhoneNumber as "Тел.номер", 
    dog.nickname as "Кличка", dog.age as "Возраст собаки", breed.name as "Порода", 
    reception.registration as "Запись о приеме", reception.date as "Дата посещения", 
    doctor.fullName as "ФИО доктора", clinicservices.name as "Услуги клиники"
	from reception
	join doctor on doctor.id = reception.doctor_id
	join dog on dog.id = reception.dog_id
	join reception_clinicservices on reception_clinicservices.reception_id = reception.id
	join clinicservices on clinicservices.id = reception_clinicservices.clinicservices_id
	join breed on breed.id = dog.breed_id
	join owner on owner.id = dog.owner_id;

select * from view_owner;



