package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.base.data.BptElectronic;

/**
 * @title:IBptElectronicDao
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
public interface IBptElectronicDao extends BaseCURD<BptElectronic>{
	public void save(List<BptElectronic> list);
	/**
	 * 优抚对象信息管理修改人员信息，选择档案目录，加入公共目录部分
	 */
	public DataSet queryBaseInforSelectedContents(ParameterSet pset);
	
	/**
	 * 查询已经选择的档案目录
	 */
	public DataSet querySelectedContents(ParameterSet pset);
	
	public DataSet queryProcessElectronicPrint(ParameterSet pSet);
	
	public DataSet queryContentPeople(ParameterSet pset);
	
	public DataSet queryElectronicPrintCover(ParameterSet pSet);
	/**
	 * 根据applyId删除信息
	 * @param pset
	 */
	public void delElectByApplyId(ParameterSet pset);
}

