//���� ������ �������� ���������.
var/global/list/profs_list = list(
	"Captain"="�������",
	"Assistant"="���������",
	"Chaplain"="��������",
	"Security Officer"="������ ������ ������������",
	"Cook"="�����",
	"Chief Engineer"="������� �������",
	"Station Engineer"="�������",
	"Atmospheric Technician"="����������� ������",
	"Clown"="�����",
	"Mime"="���",
	"Botanist"="�������",
	"Medical Doctor"="�����",
	"Cargo Technician"="�������",
	"Head of Personnel"="����� ���������",
	"Head of Security"="����� ������ ������������",
	"Warden"="�����������",
	"Detective"="��������",
	"Lawyer"="�������",
	"Quartermaster"="������",
	"Scientist"="������",
	"Shaft Miner"="������",
	"Chemist"="�����",
	"Janitor"="�������",
	"Geneticist"="�������",
	"Virologist"="���������",
	"Roboticist"="��������",
	"Bartender"="������",
	"Research Director"="����� ������ ������������",
	"Chief Medical Officer"="��������",
	)	//����� ��������� � ����� //|""="",| �����������

/proc/ranged_R(var/t, var/type, var/chars_ed) //��������� ��� �������� �������� ���������
	if(!type)
		chars_ed = profs_list //���������� ����� ���������
	if(type == "locates")
		chars_ed = locs_list //���������� ����� �������
	for(var/char in chars_ed)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + chars_ed[char] //������
			index = findtext(t, char)
	return t

//���� ������ �������� ���������.
var/global/list/locs_list = list(
	"Room"="�������",	//����
	)	//����� ��������� � ����� //|""="",| �����������