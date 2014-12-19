package com.inspur.cams.bpt.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptElectronic;

public interface IBptElectronicDomain {
	public void batchInsert(List list);
	/**
	 * 优抚对象信息管理修改人员信息，选择档案目录，加入公共目录部分
	 */
	public DataSet queryBaseInforSelectedContents(ParameterSet pset);
	/**
	 * 插入一条记录
	 */
	public void insert(BptElectronic bptElectronic);
	
	/**
	 * 修改记录
	 */
	public void update(BptElectronic bptElectronic);
	
	/**
	 * 查询记录
	 */
	public DataSet query(ParameterSet pset);
	
	 /**
	 * 查询已经选择的档案目录
	 */
	public DataSet querySelectedContents(ParameterSet pset);
	/**
	 * 查询已经选择的档案目录打印
	 */
	public DataSet queryProcessElectronicPrint(ParameterSet pSet);
	
	public DataSet queryContentPeople(ParameterSet pset);
	
	public DataSet queryElectronicPrintCover(ParameterSet pSet);
	/**
	 * 根据applyId删除信息
	 * @param pset
	 */
	public void delElectByApplyId(ParameterSet pset);
}
