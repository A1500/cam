package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmQualificationExam;

/**
 * @title:IMrmQualificationExamDao
 * @description:
 * @author:
 * @since:2011-12-01
 * @version:1.0
*/
 public interface IMrmQualificationExamDao extends BaseCURD<MrmQualificationExam>{
	public void save(List<MrmQualificationExam> list);

	public DataSet queryPersonExam(ParameterSet pset);
	public DataSet queryPersonExamExcel(ParameterSet pset);

	//批量设置合格
	public Object plkshgExam(String ksxxId);
}

