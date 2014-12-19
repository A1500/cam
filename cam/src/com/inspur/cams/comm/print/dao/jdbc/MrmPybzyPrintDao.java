package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.marry.base.data.MrmFdy;

public class MrmPybzyPrintDao extends IPrintDao{

	@Override
	public DataSet queryData(ParameterSet pset) {
		String pybzyId = (String) pset.getParameter("pybzyId");
		StringBuffer sqlFdy = new StringBuffer();
		sqlFdy.append("select t.organ_id,t.pybzy_id,t.name,DECODE(t.xb, 1, '男', 2, '女') xb,t.nl,");
		sqlFdy.append("( case t.hyzk when '10' then '研究生' when '20' then  '大学本科'");
		sqlFdy.append(" when '30' then  '大学专科或专科学校' when '40' then  '中等专业学校或中等技校'");
		sqlFdy.append(" when '50' then  '技工学校' when '60' then  '高中'");
		sqlFdy.append(" when '70' then  '初中' when '80' then  '小学' when '90' then  '文盲或半文盲' end) hyzk,");
		sqlFdy.append("t.ywzyzs,DECODE(t.ryly,'01','政府购买服务','02','公开招募','03','志愿者','04','其他') ryly,");
		sqlFdy.append("t.zgzsbh,t.pyyy,t.bz,t.workbegin_time,t.workend_time,DECODE(t.zy,'01','心理咨询','03','法律') zy,");
		sqlFdy.append("t.zc,DECODE(t.zyzgz,'01','社工资格','02','心理咨询师资格','03','婚姻家庭咨询师资格','04','律师资格') zyzgz,");
		sqlFdy.append("t.organ_work from MRM_PYBZY t");
		
		if (pybzyId != null && !"".equals(pybzyId)) {
			sqlFdy.append(" where t.pybzy_id = ?");
		}
		return this.executeDataset(sqlFdy.toString(),new int[]{Types.VARCHAR},new Object[]{pybzyId},true);
	}

	@Override
	protected Class getEntityClass() {
		return MrmFdy.class;
	}

}
