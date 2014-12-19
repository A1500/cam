package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisEquipmentRepairDao;
import com.inspur.cams.fis.base.data.FisEquipmentRepair;
import com.inspur.cams.fis.base.domain.IFisEquipmentRepairDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisEquipmentRepairDomain  
 * @Description: TODO 殡葬业务维修记录表domain实现
 * @author wangziming
 * @date 2011-11-15
 */
 public class FisEquipmentRepairDomain implements IFisEquipmentRepairDomain{

	 	@Reference
	 	private IFisEquipmentRepairDao fisEquipmentRepairDao;
	 
		public DataSet query(ParameterSet pset){
			return fisEquipmentRepairDao.query(pset);
		}
		
		public void insert(FisEquipmentRepair fisEquipmentRepair){
			fisEquipmentRepairDao.insert(fisEquipmentRepair);
		}

		public void batchInsert(List<FisEquipmentRepair> list){
			fisEquipmentRepairDao.batchInsert(list);
		}
		
		public void update(FisEquipmentRepair fisEquipmentRepair){
			fisEquipmentRepairDao.update(fisEquipmentRepair);
		}
		
		public void batchUpdate(List<FisEquipmentRepair> list){
			fisEquipmentRepairDao.batchUpdate(list);
		}
		public void delete(String[] delIds){
			fisEquipmentRepairDao.batchDelete(delIds);
		}
		
		public void save(List<FisEquipmentRepair> list){
			fisEquipmentRepairDao.save(list);
		}
}