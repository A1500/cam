package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyHouseDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;

/**
 * 家庭房产信息Cmd
 */
public class SamFamilyHouseCmd extends BaseAjaxCommand {
	SamFamilyHouseDao dao = (SamFamilyHouseDao) DaoFactory.getDao(SamFamilyHouseDao.class);
	/**
	 * 保存
	 */
	@Trans
	public void save(){
		Record record = (Record) getParameter("record");
		SamFamilyHouse databean=(SamFamilyHouse)record.toBean(SamFamilyHouse.class);
		String houseId=databean.getHouseId();
		if("".equals(houseId) || houseId == null){//新增
			databean.setHouseId(IdHelp.getUUID32());
			dao.insert(databean);
		}else{//修改
			dao.update(databean);
		}
	}
	/**
	 * 删除
	 */
	@Trans
	public void delete() {
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}
