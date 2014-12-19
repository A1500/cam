package com.inspur.cams.bpt.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptElectronicDao;
import com.inspur.cams.bpt.base.data.BptElectronic;
import com.inspur.cams.bpt.base.domain.IBptElectronicDomain;

public class BptElectronicDomain implements IBptElectronicDomain {
	@Reference
	private IBptElectronicDao ElectronicDao;
	/**
	 * 优抚对象信息管理修改人员信息，选择档案目录，加入公共目录部分
	 */
	public DataSet queryBaseInforSelectedContents(ParameterSet pset){
		return ElectronicDao.queryBaseInforSelectedContents(pset);
	}
	
	public void batchInsert(List list) {
		ElectronicDao.batchInsert(list);
    }
	
	/**
	 * 插入一条记录
	 */
	public void insert(BptElectronic bptElectronic){
		ElectronicDao.insert(bptElectronic);
	}
	
	/**
	 * 修改记录
	 */
	public void update(BptElectronic bptElectronic){
		ElectronicDao.update(bptElectronic);
	}
	
	/**
	 * 查询记录
	 */
	public  DataSet query(ParameterSet pset){
		return ElectronicDao.query(pset);
	}
	
	 /**
	 * 查询已经选择的档案目录
	 */
	public DataSet querySelectedContents(ParameterSet pset){
		return ElectronicDao.querySelectedContents(pset);
	}
	/**
	 * 查询已经选择的档案目录打印
	 */
	public DataSet queryProcessElectronicPrint(ParameterSet pSet){
		return ElectronicDao.queryProcessElectronicPrint(pSet);
	}
	public DataSet queryContentPeople(ParameterSet pset){
		return ElectronicDao.queryContentPeople(pset);
	}
	public DataSet queryElectronicPrintCover(ParameterSet pSet){
		return ElectronicDao.queryElectronicPrintCover(pSet);
	}
	/**
	 * 根据applyId删除信息
	 * @param pset
	 */
	public void delElectByApplyId(ParameterSet pset){
		ElectronicDao.delElectByApplyId(pset);
	}
}
