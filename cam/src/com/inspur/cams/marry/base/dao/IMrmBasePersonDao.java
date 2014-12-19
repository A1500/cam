package com.inspur.cams.marry.base.dao;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmBasePerson;

/**
 * @title:IMrmBasePersonDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IMrmBasePersonDao extends BaseCURD<MrmBasePerson>{
	public void save(List<MrmBasePerson> list);
	public boolean  getByLoginId(String organCode);
	public String getDeptId(String loginid);
	public String updatePhoto(String photo,String photoTemp);
	public String updateQm(String qmName,String qmTemp);
	public DataSet examApplyDataSet(ParameterSet parameterSet);
	public void updateBzy(MrmBasePerson mrmBasePerson);
	public BigDecimal getDjyNum(String deptId);//登记员人数
	public BigDecimal getBzyNum(String deptId);//获得颁证员人数
	public BigDecimal getXzbzNum(String deptId);//行政编制人数
	public BigDecimal getCgglNum(String deptId);//参公管理事业编人数
	public BigDecimal getQebkNum(String deptId);//全额拨款事业编人数
	//登记员证号
	public void updateCertificate(MrmBasePerson mPerson);
	//办证员证号
	public void updateBzyzh(MrmBasePerson mPerson);
}

