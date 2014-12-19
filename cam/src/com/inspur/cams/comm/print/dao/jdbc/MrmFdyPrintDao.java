package com.inspur.cams.comm.print.dao.jdbc;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmFdy;

public class MrmFdyPrintDao extends IPrintDao{


	@Override
	public DataSet queryData(ParameterSet pset) {
		String fdyId = (String) pset.getParameter("fdyId");
		StringBuffer sqlFdy = new StringBuffer();
		sqlFdy.append("select t.organ_id,t.fdy_id,t.name,");
		sqlFdy.append("DECODE(t.xb, 1, '男', 2, '女') xb,t.nl,");
		sqlFdy.append("(case t.hyzk when '10' then '研究生' when '20' then  '大学本科'");
		sqlFdy.append("when '30' then  '大学专科或专科学校' when '40' then  '中等专业学校或中等技校' when '50' then  '技工学校' when '60' then  '高中' when '70' then  '初中' when '80' then  '小学' when '90' then  '文盲或半文盲' end) hyzk,");
		sqlFdy.append("t.ywzyzs,");
		sqlFdy.append("DECODE(t.ryly,'01','政府购买服务','02','公开招募','03','志愿者','04','其他') ryly,");
		sqlFdy.append("t.qtqk,t.bz, t.workbegin_time,t.workend_time,");
		sqlFdy.append("DECODE(t.zy,'01','心理咨询','03','法律') zy,");
		sqlFdy.append("t.zc,");
		sqlFdy.append("DECODE(t.zyzgz,'01','社工资格','02','心理咨询师资格','03','婚姻家庭咨询师资格','04','律师资格') zyzgz,");
		sqlFdy.append("t.organ_work,");
		sqlFdy.append("from MRM_FDY t");
	if (fdyId != null && !"".equals(fdyId)) {
		sqlFdy.append(" where t.fdy_id = ? ");
	}
	return this.executeDataset(sqlFdy.toString(),true);
}	

	@Override
	protected Class getEntityClass() {
		return MrmFdy.class;
	}

}
