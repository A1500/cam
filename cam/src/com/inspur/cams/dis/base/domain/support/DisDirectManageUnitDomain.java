package com.inspur.cams.dis.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDisDirectManageUnitDao;
import com.inspur.cams.dis.base.data.DisDirectManageUnit;
import com.inspur.cams.dis.base.domain.IDisDirectManageUnitDomain;

/**
 * 直管单位配置表domain
 * @author 
 * @date 2012-11-19
 */
public class DisDirectManageUnitDomain implements IDisDirectManageUnitDomain {

	@Reference
	private IDisDirectManageUnitDao disDirectManageUnitDao;

	/**
	 * 查询 直管单位配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return disDirectManageUnitDao.query(pset);
	}

	/**
	 * 获取 直管单位配置表
	 * @param pset
	 * @return
	 */
	public DisDirectManageUnit get(String rId) {
		return disDirectManageUnitDao.get(rId);
	}

	/**
	 * 增加 直管单位配置表
	 * @param disDirectManageUnit
	 */
	public void insert(DisDirectManageUnit disDirectManageUnit) {
		disDirectManageUnitDao.insert(disDirectManageUnit);
	}
	
	/**
	 * 修改 直管单位配置表
	 * @param disDirectManageUnit
	 */
	public void update(DisDirectManageUnit disDirectManageUnit) {
		disDirectManageUnitDao.update(disDirectManageUnit);
	}
	
	/**
	 * 删除 直管单位配置表
	 * @param rId
	 */
	public void delete(String rId) {
		disDirectManageUnitDao.delete(rId);
	}
	
	/**
	 * 保存(如果已经存在，则将inUse字段改为1)
	 */
	public void save(ParameterSet pset){
		Record[] records = (Record[])pset.getParameter("records");
		for(int i=0;i<records.length;i++){
			DisDirectManageUnit bean = (DisDirectManageUnit)records[i].toBean(DisDirectManageUnit.class);
			String tempId = bean.getTempId();
			DisDirectManageUnit beanReturn = disDirectManageUnitDao.get(tempId);
			String tempIdReturn = new String();
			try{
				tempIdReturn = beanReturn.getTempId();
			}catch(NullPointerException e){
				
			}
			if(StringUtils.isNotEmpty(tempIdReturn)){
				beanReturn.setInUse("1");
				disDirectManageUnitDao.update(beanReturn);
			}else{
				disDirectManageUnitDao.insert(bean);
			}
		}
	}
	
	/**
	 * 删除（将inUse字段改为0，并为删除数据库）
	 */
	public void deleteInUse(ParameterSet pset){
		Record record = (Record)pset.getParameter("record");
		DisDirectManageUnit bean = (DisDirectManageUnit)record.toBean(DisDirectManageUnit.class);
		disDirectManageUnitDao.update(bean);
	}
	
	/**
	 * @Description: 查询指定单位下的所有直属单位
	 * @author xuexzh
	 */
	public DataSet queryAllUnit(ParameterSet pset) {
		return disDirectManageUnitDao.queryAllUnit(pset);
	}
	
}