package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptArchivalFondsNumberDao;
import com.inspur.cams.bpt.base.data.BptArchivalFondsNumber;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:BptArchivalFondsNumberCommand
 * @description:全宗号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
public class BptArchivalFondsNumberCommand extends BaseAjaxCommand{
	private BptArchivalFondsNumberDao dao = (BptArchivalFondsNumberDao)DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptArchivalFondsNumberDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptArchivalFondsNumber dataBean=(BptArchivalFondsNumber)record.toBean(BptArchivalFondsNumber.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptArchivalFondsNumber dataBean=(BptArchivalFondsNumber)record.toBean(BptArchivalFondsNumber.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		Record record = (Record) getParameter("records");
		List<BptArchivalFondsNumber> list = new ArrayList<BptArchivalFondsNumber>();
		String organCode = (String) getParameter("organCode");
		String organName = (String) getParameter("organName");
			BptArchivalFondsNumber dataBean = (BptArchivalFondsNumber) record.toBean(BptArchivalFondsNumber.class);
			if(dataBean.isNew()){
				dataBean.setArchivalFondsId(IdHelp.getUUID30());
				dataBean.setDomicileCode(organCode);
				dataBean.setDomicileName(organName);
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
			}else{
				dataBean.setRegId(BspUtil.getEmpOrganId());
				dataBean.setRegTime(DateUtil.getTime());
			}
			list.add(dataBean);
		dao.save(list);
	}
}
