package com.inspur.cams.marry.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmBasePerson;
import com.inspur.cams.marry.base.data.MrmQualificationExam;

public interface IMrmQualificationExamDomain {

	//查询
	public DataSet queryMrmQualificationExam(ParameterSet pSet);
	public DataSet queryPersonExam(ParameterSet pSet);
	//增加
	public void insertMrmQualificationExam(MrmQualificationExam mExam);
	//修改
	public void updateMrmQualificationExam(MrmQualificationExam mQualificationExam);
	//修改
	public void updateMrmQualification(MrmQualificationExam mQualificationExam,MrmBasePerson mrmBasePerson);
	//删除
	public void deleteMrmQualificationExam(String ksxxId);
	//批量设置合格
	public void plkshgExam(String ksxxId);
	
	public void batchInsert(List<MrmQualificationExam> list);
	//导出excel
	public DataSet queryPersonExamExcel(ParameterSet pSet);
	
}
