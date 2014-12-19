package com.inspur.cams.fis.base.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.fis.base.data.FisEquipmentRepair;
import com.inspur.cams.fis.base.domain.IFisEquipmentRepairDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisEquipmentRepairCmd
 * @Description: TODO 殡葬业务维修记录表Cmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentRepairCmd extends BaseAjaxCommand {

	IFisEquipmentRepairDomain service = ScaComponentFactory.getService(IFisEquipmentRepairDomain.class, "FisEquipmentRepairDomain/FisEquipmentRepairDomain");

	public void insert() {
	}

	public void update() {
	}

	public void delete() {
	}

	public void save() {
	}
}
