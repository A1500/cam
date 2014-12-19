package com.inspur.cams.sorg.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomSignet;
import com.inspur.cams.sorg.base.data.SomSignetDirectory;
import com.inspur.cams.sorg.base.domain.ISomSignetDomain;

public class SomSignetCmd extends BaseAjaxCommand {

	private ISomSignetDomain somSignetDomain = ScaComponentFactory.getService(
			ISomSignetDomain.class, "somSignetDomain/somSignetDomain");

	// 插入
	public void insert() {
		SomSignet dataBean = getSomSignet();
		somSignetDomain.insert(dataBean);
	}

	// 更新
	public void update() {
		SomSignet dataBean = getSomSignet();
		somSignetDomain.update(dataBean);
	}
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somSignetDomain.del(taskCode);
	}

	private SomSignet getSomSignet() {
		Record record = (Record) getParameter("somSignetRecord");
		Record[] somSignetDirectoryRds = (Record[]) getParameter("somSignetDirectoryRds");
		SomSignet dataBean = (SomSignet) record.toBean(SomSignet.class);
		List<SomSignetDirectory> somSignetDirectoryList = new ArrayList<SomSignetDirectory>();
		if (somSignetDirectoryRds != null) {
			for (int i = 0; i < somSignetDirectoryRds.length; i++) {
				SomSignetDirectory somSignetDirectory = (SomSignetDirectory) somSignetDirectoryRds[i]
						.toBean(SomSignetDirectory.class);
				if (somSignetDirectory.getState() == Record.STATE_NEW) {
					somSignetDirectory.setDirectoryId(IdHelp.getUUID32());
				}
				somSignetDirectoryList.add(somSignetDirectory);
			}
		}
		dataBean.setSomSignetDirectoryList(somSignetDirectoryList);
		return dataBean;
	}
}
