package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao;
import com.inspur.cams.welfare.base.data.WealCert;
import com.inspur.cams.welfare.base.data.WealElectronicfileContent;

/**
 * WealElectronicfileContentCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealElectronicfileContentCommand extends BaseAjaxCommand{
	private WealElectronicfileContentDao dao = (WealElectronicfileContentDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealElectronicfileContent dataBean=(WealElectronicfileContent)record.toBean(WealElectronicfileContent.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealElectronicfileContent dataBean=(WealElectronicfileContent)record.toBean(WealElectronicfileContent.class);
		dao.update(dataBean);
	}
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	private static int maxFileSize = 20 * 1024 * 1024;
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(){
		Record uploadRd = (Record) getParameter("uploadRd");
		String fileMess = (String) getParameter("fileMess");
		WealElectronicfileContent electronicBean = (WealElectronicfileContent) uploadRd.toBean(WealElectronicfileContent.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		// 遍历Map，封装成_InformAttachment对象，并放入List中。
		List<WealElectronicfileContent> list = new ArrayList<WealElectronicfileContent>();
		while (iterator.hasNext()) {
			uploadfile = iterator.next().getValue();
			if (uploadfile.getFileSize() > maxFileSize) {
				throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
			}
			// 如果为空，则不在进行对象封装，继续遍历下一条记录。
			if (uploadfile == null) {
				continue;
			}
			WealElectronicfileContent dataBean = new WealElectronicfileContent();
			dataBean.setContentId(IdHelp.getUUID32());
			dataBean.setApplyId(electronicBean.getApplyId());
			dataBean.setApplyType(electronicBean.getApplyType());
			dataBean.setCatalogId(electronicBean.getCatalogId());
			dataBean.setCatalogNote(fileMess);
			dataBean.setContent(uploadfile);
			dataBean.setCatalogName(uploadfile.getFileName());
			dataBean.setCatalogSn(electronicBean.getCatalogSn());
			dataBean.setCompanyType(electronicBean.getCompanyType());
			dataBean.setCompanyName(electronicBean.getCompanyName());
			dataBean.setDomicileCode(electronicBean.getDomicileCode());
			
			
			list.add(dataBean);
		}
		
		dao.batchInsert(list);
		
	}
}
