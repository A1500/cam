package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.sam.dao.jdbc.SamFamilyEstateDao;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;

/**
 * 家庭财产信息Cmd
 */
public class SamFamilyEstateCmd extends BaseAjaxCommand {
	SamFamilyEstateDao dao = (SamFamilyEstateDao) DaoFactory.getDao(SamFamilyEstateDao.class);
	/**
	 * 保存
	 */
	@Trans
	public void save(){
		Record record = (Record) getParameter("record");
		SamFamilyEstate databean=(SamFamilyEstate)record.toBean(SamFamilyEstate.class);
		String estateId=databean.getEstateId();
		if("".equals(estateId) || estateId == null){//新增
			databean.setEstateId(IdHelp.getUUID32());
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
