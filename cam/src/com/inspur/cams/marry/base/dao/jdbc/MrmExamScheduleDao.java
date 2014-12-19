package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.dao.IMrmExamScheduleDao;
import com.inspur.cams.marry.base.data.MrmExamSchedule;

/**
 * @title:MrmExamScheduleDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public class MrmExamScheduleDao extends EntityDao<MrmExamSchedule> implements IMrmExamScheduleDao{

 	public MrmExamScheduleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return MrmExamSchedule.class;
	}
   
   //根据期数、年份、标识查询报名人数
   public DataSet sumExamSchedule(ParameterSet pset){
	   String ksqs = (String) pset.getParameter("ksqs");//考试期数
	   String ndYear = (String) pset.getParameter("nd_year");//年份
	   String ksSign = (String) pset.getParameter("ksSign");//标识
	   String ksapId = (String) pset.getParameter("ksapId");//考试安排
	   
	   StringBuffer examSql = new StringBuffer();
	   examSql.append("select count(q.ksxx_id) as ksrs from mrm_qualification_exam q,mrm_base_person m,");
	   examSql.append("mrm_exam_schedule s where q.person_id = m.person_id and q.ksap_id = s.ksap_id ");
	   
	   List typeList = new ArrayList();
	   List<Object> argesList = new ArrayList();
	   if (ksqs != null && !"".equals(ksqs)) {
		   examSql.append(" and q.nd_year = ? ");
		   typeList.add(Types.VARCHAR);
		   argesList.add(ksqs);
	   }
	   if (ndYear != null && !"".equals(ndYear)) {
		   examSql.append(" and q.ksqs = ?");
		   typeList.add(Types.VARCHAR);
		   argesList.add(ndYear);
	   }
	   if (ksSign != null && !"".equals(ksSign)) {
		   examSql.append(" and s.ks_sign = ?");
		   typeList.add(Types.VARCHAR);
		   argesList.add(ksSign);
	   }
	   if (ksapId != null && !"".equals(ksapId)) {
		   examSql.append(" and q.ksap_id = ?");
		   typeList.add(Types.VARCHAR);
		   argesList.add(ksapId);
	   }
	   
	   
	   	DataSet dataSet = null;
		if (typeList.size() != 0 && argesList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argesList.toArray(new Object[typeList.size()]);
			
			dataSet =  this.executeDataset(examSql.toString(), types, args, true);
		}else {
			dataSet =  this.executeDataset(examSql.toString(), true);
		}
		return dataSet;
   }
   
}
