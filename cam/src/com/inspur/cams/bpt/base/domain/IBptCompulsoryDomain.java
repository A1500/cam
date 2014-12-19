package com.inspur.cams.bpt.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptCompulsory;


public interface IBptCompulsoryDomain {
	/**
 	* 厂家查询
 	*/
	public DataSet query(ParameterSet pset);

/**
 	* 厂家维护
 	*/
	@Trans//@Trans注释用来声明这个功能方法在事务中
	public void save(List<BptCompulsory> list);
	public DataSet queryCompulsory(ParameterSet pSet);

}
