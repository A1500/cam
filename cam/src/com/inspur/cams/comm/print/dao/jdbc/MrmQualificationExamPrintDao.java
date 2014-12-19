package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;

public class MrmQualificationExamPrintDao extends IPrintDao {

	@Override
	public DataSet queryData(ParameterSet pset) {
		// TODO Auto-generated method stub
		String kssxxId = (String) pset.getParameter("ksxxId");
		StringBuffer kssxxSql = new StringBuffer();
		kssxxSql.append("select (case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,0,Length(r.name)-8) else substr(r.name,0,Length(r.name)-8) || '民政局' END) shiqu,");
		kssxxSql.append("(case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,Length(r.name)-7) else substr(r.name,Length(r.name)-4) END) dengji,");
		kssxxSql.append("m.name,m.name as nameOther,(case m.sex when '1' then '男' when '2' then  '女' end) as sex,");
		kssxxSql.append("m.card_no,(case m.technical when '01' then '主任' when '02' then  '副主任' when '03' then '登记员' when '04' then  '颁证员' when '05' then  '聘用社工' when '06' then  '其他人员' end) as technical,");
		kssxxSql.append("m.dept_name,e.organ_id,e.ksxx_id,e.ksap_id,e.person_id,e.nd_year,e.ksqs,e.kssj_time,");
		kssxxSql.append("e.ksjg,e.bkjg,e.ckfkbz,m.certificate_id,e.fill_card_time,e.give_out_time,e.automatic_failure_time,");
		kssxxSql.append("e.backout_time,m.bzyzgzh,r.name as deptName,");
		kssxxSql.append("substr(e.give_out_time,0,4) as year ,substr(e.give_out_time,6,2) as month,substr(e.give_out_time,9,10) as day ");
		kssxxSql.append(" from MRM_BASE_PERSON m, MRM_QUALIFICATION_EXAM e,MRM_REGIS_ORGAN_INFO r");
		kssxxSql.append(" where m.person_id = e.person_id and r.dept_code = m.dept_id");

		if (kssxxId != null && !"".equals(kssxxId)) {
			kssxxSql.append(" and e.ksxx_id = ?");
		}
		return this.executeDataset(kssxxSql.toString(),new int[]{Types.VARCHAR},new Object[]{kssxxId}, true);
	}

	/**
	 * 登记员考试资格打证
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryMarryExam(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append("select m.name,(case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,0,Length(r.name)-8) else substr(r.name,0,Length(r.name)-8) || '民政局' END) shiqu,");
		sql.append("(case  substr(r.name,Length(r.name)-8,1) when '区' then substr(r.name,Length(r.name)-7) else substr(r.name,Length(r.name)-4) END) dengji,");
		sql.append("DECODE(m.sex, 1, '男', 2, '女') sex,m.card_no,");
		sql.append("(case m.technical when '01' then '主任' when '02' then  '副主任' when '03' then '登记员' when '04' then  '颁证员' when '05' then  '聘用社工' when '06' then  '其他人员' end) as technical,");
		sql.append("m.dept_name,m.duty,m.certificate_id,to_char(to_date(e.give_out_time, 'yyyy-MM-dd'),");
		sql.append("'YYYY\"年\"fmMM\"月\"fmDD\"日') as give_out_time, '内地居民' as scopeName,");
		//sql.append(" substr(e.give_out_time,0,4) as year ,substr(e.give_out_time,6,2) as month,substr(e.give_out_time,9,10) as day ");
		sql.append(" substr(m.djyccfzsj,0,4) as year ,substr(m.djyccfzsj,6,2) as month,substr(m.djyccfzsj,9,10) as day ");
		sql.append(" from MRM_BASE_PERSON m, MRM_QUALIFICATION_EXAM e,MRM_REGIS_ORGAN_INFO r");
		sql.append(" where m.person_id = e.person_id and r.dept_code = m.dept_id and  e.ksxx_id = ?");

		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ksxxId") }, true);
	}

	@Override
	protected Class getEntityClass() {
		// TODO Auto-generated method stub
		return MrmBasePerson.class;
	}

}
