package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;

public class MrmBasePersonPrintDao extends IPrintDao {

	@Override
	public DataSet queryData(ParameterSet pset) {
		String personId = (String) pset.getParameter("personId");
		StringBuffer sqlPerson = new StringBuffer();
		sqlPerson.append("select m.name,m.nation,m.sex,m.birth_date,m.card_no,m.degree,m.specialty,m.college,");
		sqlPerson.append("m.culture,m.specialty,m.duty,m.work_no,m.mobile,m.work_date,m.kind,m.marry_start_date,");
		sqlPerson.append("m.marry_end_date,m.organization,m.computer_type,m.certificate_id,m.party_time,");
		sqlPerson.append("m.departure_reason,m.address,m.remark from mrm_base_person m");
		
		if (personId != null && !"".equals(personId)) {
			sqlPerson.append(" where m.person_id = ?");
		}
		return this.executeDataset(sqlPerson.toString(),new int[]{Types.VARCHAR}, new Object[]{personId},true);
	}

	@Override
	protected Class getEntityClass() {
		return MrmBasePerson.class;
	}

	/**
	 * 登记员打印
	 */
	public DataSet printMrmPerson(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("select m.name,m.photo as PHOTO_ID,decode(m.sex,'1','男','2','女') as sex,");
		sql.append("m.card_no,(select  d.name from dic_nation d where d.code = m.nation) nation,");
		sql.append("m.birth_date,decode(m.politics,'01','中国共产党党员','02','中国共产党预备党员','03',");
		sql.append("'中国国民党革命委员会会员','04','中国民主同盟盟员','05','中国民主建国会会员','06','中国民主促进会会员',");
		sql.append("'07','中国农工民主党党员','08','中国致公党党员','09','九三学社社员','10','台湾民主自治同盟盟员','11',");
		sql.append("'无党派民主人士','12','群众') as politics,m.college,m.specialty,m.degree,decode(m.culture,'10',");
		sql.append("'研究生','20','大学本科','30','大学专科和专科学校','40','中等专业学校或中等技术学校','50','技工学校',");
		sql.append("'60','高中','70','初中','80','小学','90','文盲或半文盲') as culture,decode(m.technical,'01',");
		sql.append("'主任','02','副主任','03','登记员','04','颁证员','05','聘用社工','06','其他人员') as technical,");
		sql.append("m.mobile,m.work_date,decode(m.kind,'01','公务员','02','全额事业编','03','参公管理事业编','04',");
		sql.append("'其他') as kind,decode(m.organization, '0', '否', '1', '是') as organization,");
		sql.append("decode(m.computer_type, '01', '管理员', '02', '其他') as computer_type,m.certificate_id,");
		sql.append("m.bzyzgzh,m.party_time,decode(m.workstate, '01', '在岗', '02', '离岗', '03', '待岗') as workstate,");
		sql.append("m.marry_start_date,m.marry_end_date,decode(m.djfw_type,'01','内地居民','02','社外国人、港澳台居民、华侨') as djfw_type,");
		sql.append("m.departure_reason,m.bzy_begintime,m.bzy_endtime,m.remark,");
		sql.append("substr(m.djyccfzsj,0,4) as year ,substr(m.djyccfzsj,6,2) as month,substr(m.djyccfzsj,9,10) as day ,");
		sql.append("(case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,0,Length(r.name)-8) else substr(r.name,0,Length(r.name)-8) || '民政局' END) shiqu,");
		sql.append("(case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,Length(r.name)-7) else substr(r.name,Length(r.name)-4) END) dengji ");
		sql.append("  from MRM_REGIS_ORGAN_INFO r, mrm_base_person m where r.dept_code = m.dept_id and m.person_id=? ");

		return this.executeDataset(sql.toString(), new int[] {Types.VARCHAR},
				new Object[] {pset.getParameter("personId")}, true);
	}

}
