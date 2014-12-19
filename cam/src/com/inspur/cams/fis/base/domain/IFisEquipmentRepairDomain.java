package com.inspur.cams.fis.base.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisEquipmentRepair;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisEquipmentRepairDomain
 * @Description: TODO 殡葬业务维修记录表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisEquipmentRepairDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void insert(FisEquipmentRepair fisEquipmentRepair);

	@Trans
	public void batchInsert(List<FisEquipmentRepair> list);

	@Trans
	public void update(FisEquipmentRepair fisEquipmentRepair);

	@Trans
	public void batchUpdate(List<FisEquipmentRepair> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisEquipmentRepair> list);
}