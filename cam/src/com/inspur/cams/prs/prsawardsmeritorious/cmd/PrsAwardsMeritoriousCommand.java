package com.inspur.cams.prs.prsawardsmeritorious.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import com.inspur.cams.comm.util.IdHelp;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prsawardsmeritorious.dao.*;

/**
 * @title:PrsAwardsMeritoriousCommand
 * @description:
 * @author:
 * @since:2011-08-23
 * @version:1.0
*/
public class PrsAwardsMeritoriousCommand extends BaseAjaxCommand{
	private PrsAwardsMeritoriousDao dao = (PrsAwardsMeritoriousDao) DaoFactory
			.getDao("com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritoriousDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		PrsAwardsMeritorious dataBean=(PrsAwardsMeritorious)record.toBean(PrsAwardsMeritorious.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		PrsAwardsMeritorious dataBean=(PrsAwardsMeritorious)record.toBean(PrsAwardsMeritorious.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		Record[] records = (Record[]) getParameter("records");
		String soldierId = (String) getParameter("soldiersId");
		List<PrsAwardsMeritorious> oldlist = new ArrayList<PrsAwardsMeritorious>();
		List<PrsAwardsMeritorious> list = new ArrayList<PrsAwardsMeritorious>();
		for (int i = 0; i < records.length; i++) {
			PrsAwardsMeritorious dataBean = (PrsAwardsMeritorious) records[i].toBean(PrsAwardsMeritorious.class);
			if(dataBean.isNew()){
				dataBean.setAwardsId(IdHelp.getUUID32());
				dataBean.setsoldiersId(soldierId);
				list.add(dataBean);
			}else{
				oldlist.add(dataBean);
			}
		}
		for(PrsAwardsMeritorious award:oldlist){
			dao.update(award);
		}
		dao.save(list);
	}
}
