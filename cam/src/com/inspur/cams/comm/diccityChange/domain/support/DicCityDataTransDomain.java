package com.inspur.cams.comm.diccityChange.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.diccityChange.dao.IDicCityDataTransDao;
import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;
import com.inspur.cams.comm.diccityChange.domain.IDicCityDataTransDomain;
import com.inspur.comm.util.IdHelp;

/**
 * 数据迁移domain
 * @author 
 * @date 2013-12-23
 */
public class DicCityDataTransDomain implements IDicCityDataTransDomain {

	@Reference
	private IDicCityDataTransDao dicCityDataTransDao;

	/**
	 * 查询 数据迁移
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicCityDataTransDao.query(pset);
	}

	public DataSet getUnder(ParameterSet pset) {
		return dicCityDataTransDao.getUnder(pset);
	}
	/**
	 * 获取 数据迁移
	 * @param pset
	 * @return
	 */
	public DicCityDataTrans get(String transId) {
		return dicCityDataTransDao.get(transId);
	}

	/**
	 * 增加 数据迁移
	 * @param dicCityDataTrans
	 */
	public void insert(DicCityDataTrans dicCityDataTrans) {
		dicCityDataTransDao.insert(dicCityDataTrans);
	}
	
	/**
	 * 修改 数据迁移
	 * @param dicCityDataTrans
	 */
	public void update(DicCityDataTrans dicCityDataTrans) {
		dicCityDataTransDao.update(dicCityDataTrans);
	}
	
	/**
	 * 删除 数据迁移
	 * @param transId
	 */
	public void delete(String transId) {
		dicCityDataTransDao.delete(transId);
	}

	public void deleteByTrans(String changeId) {
		dicCityDataTransDao.deleteByTrans(changeId);
	}
	
	public void transSave(DicCityDataTrans dicCityDataTrans,String changeId,String batchId){
		if("".equals(dicCityDataTrans.getTransId())){
			dicCityDataTrans.setTransId(IdHelp.getUUID32());
			dicCityDataTrans.setChangeId(changeId);
			if("1".equals(dicCityDataTrans.getTransType())){
				dicCityDataTrans.setTransScript("bp_admstrat_division_changes('"
								+ dicCityDataTrans.getPreChangeCode()+ "','"
								+ dicCityDataTrans.getPreChangeName()+ "','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','02','"+ batchId+ "','"+ changeId+ "');");
			}else if("0".equals(dicCityDataTrans.getTransType())){
				dicCityDataTrans.setTransScript("bp_area_data_change('"
								+ dicCityDataTrans.getPreChangeCode()+ "','','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','04','"+ batchId+ "','"+ changeId + "');");
				dicCityDataTrans.setDeleteScript("bp_admstrat_division_changes('"
								+ dicCityDataTrans.getPreChangeCode()+ "','','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','03','"+ batchId+ "','"+ changeId + "');");
			}
			dicCityDataTransDao.insert(dicCityDataTrans);
		}else {
			if("1".equals(dicCityDataTrans.getTransType())){
				dicCityDataTrans.setTransScript("bp_admstrat_division_changes('"
								+ dicCityDataTrans.getPreChangeCode()+ "','"
								+ dicCityDataTrans.getPreChangeName()+ "','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','02','"+ batchId+ "','"+ changeId+ "');");
			}else if("0".equals(dicCityDataTrans.getTransType())){
				dicCityDataTrans.setTransScript("bp_area_data_change('"
								+ dicCityDataTrans.getPreChangeCode()+ "','"
								+ dicCityDataTrans.getPreChangeName()+ "','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','04','" + batchId + "','"
								+ changeId + "','"+ dicCityDataTrans.getTransId() + "');");
				dicCityDataTrans.setDeleteScript("bp_admstrat_division_changes('"
								+ dicCityDataTrans.getPreChangeCode()+ "','','"
								+ dicCityDataTrans.getPostChangeCode()+ "','"
								+ dicCityDataTrans.getPostChangeName()
								+ "','','03','"+ batchId+ "','"+ changeId + "');");
			}
			dicCityDataTransDao.update(dicCityDataTrans);
		}
	}
}