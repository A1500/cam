package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmQualificationExamDao;
import com.inspur.cams.marry.base.data.MrmQualificationExam;

import flex.messaging.io.ArrayList;

/**
 * @title:MrmQualificationExamDao
 * @description:
 * @author:
 * @since:2011-12-01
 * @version:1.0
 */
public class MrmQualificationExamDao extends EntityDao<MrmQualificationExam>
		implements IMrmQualificationExamDao {

	public MrmQualificationExamDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return MrmQualificationExam.class;
	}

	//登记员资格考试信息
	public DataSet queryPersonExam(ParameterSet pset) {
		String personId = (String) pset.getParameter("personId");
		String name = (String) pset.getParameter("name");// 姓名
		String ndYear = (String) pset.getParameter("ndYear");// 年度
		String ksqs = (String) pset.getParameter("ksqs");// 考试期数
		String kssjTime = (String) pset.getParameter("kssjTime");// 考试时间
		String ksjg = (String) pset.getParameter("ksjg");// 考试结果
		String bkjg = (String) pset.getParameter("bkjg");// 补考结果
		String certificateId = (String) pset.getParameter("certificateId");// 登记员资格证编号
		String fillCardTime = (String) pset.getParameter("fillCardTime");// 是否补证
		String organId = (String) pset.getParameter("organId");//所属地区
		String deptId = (String) pset.getParameter("deptId");//所属部门
		String bzyCode = (String) pset.getParameter("bzyCode");//人员标识
		String ksSign = (String) pset.getParameter("ksSign");//考试安排 0：登记员   1：颁证员
		String bzyzgzh = (String) pset.getParameter("bzyzgzh");//颁证员资格证编号

		StringBuffer sqlPersonExam = new StringBuffer();
		sqlPersonExam.append("select m.name,m.dept_name,m.bzyzgzh,e.organ_id, e.ksxx_id,e.ksap_id,e.person_id,");
		sqlPersonExam.append("e.nd_year,e.ksqs,e.kssj_time,e.ksjg,e.bkjg,e.ckfkbz, m.certificate_id,e.fill_card_time,");
		sqlPersonExam.append("e.give_out_time,e.automatic_failure_time,e.backout_time,e.zgzzt,e.cxyy ");
		sqlPersonExam.append(" from MRM_BASE_PERSON m, MRM_QUALIFICATION_EXAM e,mrm_exam_schedule s ");
		sqlPersonExam.append(" where m.person_id = e.person_id and e.ksap_id = s.ksap_id");

		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		if (name != null && !"".equals(name)) {
			sqlPersonExam.append(" and m.name like  ?");
			typeList.add(Types.VARCHAR);
			argesList.add("%"+name+"%");
		}
		
		if (ndYear != null && !"".equals(ndYear)) {
			sqlPersonExam.append(" and e.nd_year = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ndYear);
		}
		if (ksqs != null && !"".equals(ksqs)) {
			sqlPersonExam.append(" and e.ksqs = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksqs);
		}
		if (kssjTime != null && !"".equals(kssjTime)) {
			sqlPersonExam.append(" and e.kssj_time = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(kssjTime);
		}
		if (ksjg != null && !"".equals(ksjg)) {
			sqlPersonExam.append(" and e.ksjg = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksjg);
		}
		if (bkjg != null && !"".equals(bkjg)) {
			sqlPersonExam.append(" and e.bkjg = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bkjg);
		}
		if (bzyzgzh != null && !"".equals(bzyzgzh)) {
			sqlPersonExam.append(" and m.bzyzgzh = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyzgzh);
		}
		if (certificateId != null && !"".equals(certificateId)) {
			sqlPersonExam.append(" and m.certificate_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(certificateId);
		}
		if (fillCardTime != null && !"".equals(fillCardTime)) {
			sqlPersonExam.append(" and e.fill_card_time = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(fillCardTime);
		}
		if (organId != null && !"".equals(organId)) {
			sqlPersonExam.append(" and e.organ_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(organId);
		}
//		if (deptId != null && !"".equals(deptId)) {
//			if (deptId.substring(4).equals("0001")) {
//			//	sqlPersonExam.append(" and substr(m.dept_id,1,4) = ?");
//				sqlPersonExam.append(" and m.dept like ?");
//				typeList.add(Types.VARCHAR);
//				argesList.add(deptId.substring(0,4)+"%");
//			}else {
//				sqlPersonExam.append(" and m.dept_id = ?");
//				typeList.add(Types.VARCHAR);
//				argesList.add(deptId);
//			}
//			
//		}
		if (deptId != null && !"".equals(deptId)) {
			if (deptId.substring(4).equals("0001")) {
			//	sqlPersonExam.append(" and substr(m.dept_id,1,4) = ?");
				sqlPersonExam.append(" and m.dept_id like ?");
				typeList.add(Types.VARCHAR);
				argesList.add(deptId.substring(0,4)+"%");
			}else {
				sqlPersonExam.append(" and m.dept_id = ?");
				typeList.add(Types.VARCHAR);
				argesList.add(deptId);
			}
			
		}
		if (ksSign != null && !"".equals(ksSign)) {
			sqlPersonExam.append(" and s.ks_sign = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksSign);
		}
		if (personId != null && !"".equals(personId)) {
			sqlPersonExam.append(" and m.person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
			
		}
		if (bzyCode != null && !"".equals(bzyCode)) {
			sqlPersonExam.append(" and m.bzy_code = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyCode);
		}
		sqlPersonExam.append(" order by e.nd_year desc , e.ksqs,dept_id,m.person_id asc");
		DataSet dataSet = new DataSet();
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			dataSet = this.executeDataset(sqlPersonExam.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
		}else {
			dataSet = this.executeDataset(sqlPersonExam.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}

		return dataSet;
	}
	//导出excel
	public DataSet queryPersonExamExcel(ParameterSet pset) {
		String personId = (String) pset.getParameter("personId");
		String name = (String) pset.getParameter("name");// 姓名
		String sex = (String) pset.getParameter("sex");// 姓名
		String ndYear = (String) pset.getParameter("ndYear");// 年度
		String ksqs = (String) pset.getParameter("ksqs");// 考试期数
		String kssjTime = (String) pset.getParameter("kssjTime");// 考试时间
		String ksjg = (String) pset.getParameter("ksjg");// 考试结果
		String bkjg = (String) pset.getParameter("bkjg");// 补考结果
		String certificateId = (String) pset.getParameter("certificateId");// 资格证编号
		String fillCardTime = (String) pset.getParameter("fillCardTime");// 是否补证
		String organId = (String) pset.getParameter("organId");//所属地区
		String deptId = (String) pset.getParameter("deptId");//所属部门
		String bzyCode = (String) pset.getParameter("bzyCode");//人员标识
		String ksSign = (String) pset.getParameter("ksSign");//考试安排 0：登记员   1：颁证员
		String bzyzgzh = (String) pset.getParameter("bzyzgzh");//颁证员资格证编号
		
		StringBuffer sqlPersonExam = new StringBuffer();
		sqlPersonExam.append("select m.name,m.dept_name,(select d.name from dic_nation d where d.code =  m.nation ) as nation,m.mobile,");
		sqlPersonExam.append("e.organ_id,e.ksxx_id,e.ksap_id,e.person_id,e.nd_year,e.ksqs,e.kssj_time,e.ksjg,e.bkjg,e.ckfkbz,m.certificate_id,");
		sqlPersonExam.append("e.fill_card_time,e.give_out_time,e.automatic_failure_time,e.backout_time,e.zgzzt,m.sex,e.cxyy");
		sqlPersonExam.append(" from MRM_BASE_PERSON m, MRM_QUALIFICATION_EXAM e,mrm_exam_schedule s ");
		sqlPersonExam.append(" where m.person_id = e.person_id and e.ksap_id = s.ksap_id");
		
		List typeList = new ArrayList();
		List<Object> argesList = new ArrayList();
		if (name != null && !"".equals(name)) {
			sqlPersonExam.append(" and m.name like  ?");
			typeList.add(Types.VARCHAR);
			argesList.add("%"+name+"%");
		}
		
		if (ndYear != null && !"".equals(ndYear)) {
			sqlPersonExam.append(" and e.nd_year = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ndYear);
		}
		if (ksqs != null && !"".equals(ksqs)) {
			sqlPersonExam.append(" and e.ksqs = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksqs);
		}
		if (kssjTime != null && !"".equals(kssjTime)) {
			sqlPersonExam.append(" and e.kssj_time = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(kssjTime);
		}
		if (ksjg != null && !"".equals(ksjg)) {
			sqlPersonExam.append(" and e.ksjg = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksjg);
		}
		if (bkjg != null && !"".equals(bkjg)) {
			sqlPersonExam.append(" and e.bkjg = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bkjg);
		}
		if (bzyzgzh != null && !"".equals(bzyzgzh)) {
			sqlPersonExam.append(" and m.bzyzgzh = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyzgzh);
		}
		if (certificateId != null && !"".equals(certificateId)) {
			sqlPersonExam.append(" and m.certificate_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(certificateId);
		}
		if (fillCardTime != null && !"".equals(fillCardTime)) {
			sqlPersonExam.append(" and e.fill_card_time = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(fillCardTime);
		}
		if (organId != null && !"".equals(organId)) {
			sqlPersonExam.append(" and e.organ_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(organId);
		}
		if (deptId != null && !"".equals(deptId)) {
			if (deptId.substring(4).equals("0001")) {
			//	sqlPersonExam.append(" and substr(m.dept_id,1,4) = ?");
				sqlPersonExam.append(" and m.dept_id like ?");
				typeList.add(Types.VARCHAR);
				argesList.add(deptId.substring(0,4)+"%");
			}else {
				sqlPersonExam.append(" and m.dept_id = ?");
				typeList.add(Types.VARCHAR);
				argesList.add(deptId);
			}
			
		}
		if (ksSign != null && !"".equals(ksSign)) {
			sqlPersonExam.append(" and s.ks_sign = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(ksSign);
		}
		if (personId != null && !"".equals(personId)) {
			sqlPersonExam.append(" and m.person_id = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(personId);
			
		}
		if (bzyCode != null && !"".equals(bzyCode)) {
			sqlPersonExam.append(" and m.bzy_code = ?");
			typeList.add(Types.VARCHAR);
			argesList.add(bzyCode);
		}
		
		sqlPersonExam.append(" order by e.nd_year desc , m.dept_id,m.person_id asc");
		DataSet dataSet = new DataSet();
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			dataSet = this.executeDataset(sqlPersonExam.toString(),types,args,true);
		}else {
			dataSet = this.executeDataset(sqlPersonExam.toString(), true);
		}

		return dataSet;
	}

	//批量设置合格
	public Object plkshgExam(String ksxxId) {
		this.executeUpdate(" update MRM_QUALIFICATION_EXAM set KSJG='01' where ksxx_Id in ("+ksxxId+")");
		return null;
	}
}
