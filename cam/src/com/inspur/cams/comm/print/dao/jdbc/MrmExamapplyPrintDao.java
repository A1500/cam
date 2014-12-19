package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;

public class MrmExamapplyPrintDao  extends IPrintDao {
	//已报名人打印
	@Override
	public DataSet queryData(ParameterSet pset) {
		// TODO Auto-generated method stub
		String personId = (String) pset.getParameter("personId");
		String ksqs = (String) pset.getParameter("ksqs");
		String ndyear = (String) pset.getParameter("ndyearstring");
		String ksSign = (String) pset.getParameter("ksSign");
		StringBuffer personSql = new StringBuffer();
		personSql.append("select m.name,m.dept_name,m.name,(select d.name from dic_nation d where d.code = m.nation) as nation,");
		personSql.append("(case m.sex when '1' then '男' when '2' then  '女' end) as sex,");
		personSql.append("(case m.culture when '10' then '研究生' when '20' then  '大学本科'");
		personSql.append(" when '30' then  '大学专科或专科学校' when '40' then  '中等专业学校或中等技校'");
		personSql.append(" when '50' then  '技工学校' when '60' then  '高中'");
		personSql.append(" when '70' then  '初中' when '80' then  '小学'");
		personSql.append(" when '90' then  '文盲或半文盲' end) culture,");
		personSql.append("m.birth_date,m.card_no,m.degree,m.marry_start_date,m.marry_end_date,m.dept_name,");
		personSql.append("(case m.technical when '01' then '主任' when '02' then  '副主任' when '03' then '登记员' when '04' then  '颁证员' when '05' then  '聘用社工' when '06' then  '其他人员' end) as technical,");
		personSql.append("(case m.kind when '01' then '公务员' when '02' then  '全额事业编' when '03' then '参公管理事业编' when '04' then  '其他' end) as kind,");
		personSql.append("e.organ_id,e.ksxx_id,e.ksap_id,e.person_id,e.nd_year,e.ksqs,e.kssj_time,");
		personSql.append("(case e.ksjg when '01' then '合格' when '02' then '不合格' end) as ksjg,e.bkjg,");
		personSql.append("e.ckfkbz,m.certificate_id,m.party_time,m.bzyzgzh,e.fill_card_time,e.give_out_time,");
		personSql.append("e.automatic_failure_time,e.backout_time from MRM_BASE_PERSON m, MRM_QUALIFICATION_EXAM e, Mrm_Exam_Schedule s");
		personSql.append(" where m.person_id = e.person_id and e.ksap_id = s.ksap_id");
		
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		if (personId != null && !"".equals(personId)) {
			personSql.append(" and e.person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
		}
		if (ksqs != null && !"".equals(ksqs)) {
			personSql.append(" and e.ksqs = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksqs);
		}
		if (ndyear != null && !"".equals(ndyear)) {
			personSql.append(" and e.nd_year = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ndyear);
		}
		if (ndyear != null && !"".equals(ndyear)) {
			personSql.append(" and s.ks_sign = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksSign);
		}
		DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			dataSet =  this.executeDataset(personSql.toString(), types, args, true);
		}else {
			dataSet =  this.executeDataset(personSql.toString(), true);
		}
		
		return dataSet;
	}

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return MrmBasePerson.class;
	}

}
