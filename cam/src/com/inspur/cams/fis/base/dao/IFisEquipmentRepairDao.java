package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisEquipmentRepair;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisEquipmentRepairDao  
 * @Description: TODO 殡葬业务维修记录表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
 public interface IFisEquipmentRepairDao extends BaseCURD<FisEquipmentRepair>{
	public void save(List<FisEquipmentRepair> list);
}

