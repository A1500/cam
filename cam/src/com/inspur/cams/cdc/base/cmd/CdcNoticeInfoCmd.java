package com.inspur.cams.cdc.base.cmd;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcNoticeInfo;
import com.inspur.cams.cdc.base.domain.ICdcNoticeInfoDomain;
import com.inspur.cams.comm.comfile.data.ComFile;
import com.inspur.cams.comm.comfile.domain.ComFileDomain;
import com.inspur.cams.comm.comfile.domain.IComFileDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.IdHelp;

public class CdcNoticeInfoCmd extends BaseAjaxCommand {
	private ICdcNoticeInfoDomain service = ScaComponentFactory
	.getService(ICdcNoticeInfoDomain.class, "cdcNoticeInfoDomain/cdcNoticeInfoDomain");
	
	private IComFileDomain comFileDao = ScaComponentFactory.getService(ComFileDomain.class, "comFileDomain/comFileDomain");
	
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record"); 
		CdcNoticeInfo dataBean=(CdcNoticeInfo)record.toBean(CdcNoticeInfo.class);
		
		ComFile comFile= new ComFile();
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			try {
				uploadfile = iterator.next().getValue();
				if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
					throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
				}
				// 如果为空，则不在进行对象封装，继续遍历下一条记录。
				if (uploadfile == null) {
					continue;
				}
				String fileName =uploadfile.getFileName();
				int size =uploadfile.getFileSize();
				
				comFile.setFileSize(BigDecimal.valueOf(size));
				Blob b= new Blob();
				b.setData(uploadfile.getFileData());
				comFile.setFileContent(b);
				comFile.setFileFormat(fileName.substring(fileName.lastIndexOf(".")+1));
				//comFile.setFileType((String)record.get("noticeType"));
				String fileId=getFix("yyyyMM")+IdHelp.getUUID30();
				comFile.setFileId(fileId);
				comFile.setApplyType("cdc");
				comFile.setFileName(fileName);
				comFile.setCreateTime(getFix("yyyy-MM-dd"));
				comFile.setCreateOpr((String)record.get("username"));
				comFile.setCreateOrgan((String)record.get("organName"));
				dataBean.setFileId(fileId);
				comFileDao.save(comFile);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		dataBean.setNoticeType((String)record.get("noticeType"));
		dataBean.setNoticeId(getFix("yyyyMM")+IdHelp.getUUID30());
		dataBean.setCreateTime(getFix("yyyy-MM-dd"));
		dataBean.setFlag("0");
		service.insert(dataBean);
		
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record"); 
		CdcNoticeInfo dataBean=(CdcNoticeInfo)record.toBean(CdcNoticeInfo.class);
		String fileId=(String)record.get("fileId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("FILE_ID", fileId);
		ComFile comFile=(ComFile)comFileDao.find(pset).getRecord(0).toBean(ComFile.class);
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String, UploadFile>> set = map.entrySet();
		Iterator<Entry<String, UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		while (iterator.hasNext()) {
			try {
				uploadfile = iterator.next().getValue();
				if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
					throw new RuntimeException(uploadfile.getFileName() + "  文件过大！");
				}
				// 如果为空，则不在进行对象封装，继续遍历下一条记录。
				if (uploadfile == null) {
					continue;
				}
				String fileName =uploadfile.getFileName();
				int size =uploadfile.getFileSize();
				
				comFile.setFileSize(BigDecimal.valueOf(size));
				Blob b= new Blob();
				b.setData(uploadfile.getFileData());
				comFile.setFileContent(b);
				comFile.setFileFormat(fileName.substring(fileName.lastIndexOf(".")+1));
				comFile.setFileName(fileName);
				comFile.setApplyType("cdc");
				comFile.setCreateTime(getFix("yyyy-MM-dd"));
				comFile.setCreateOpr((String)record.get("username"));
				comFile.setCreateOrgan((String)record.get("organName"));
				if(fileId==null||"".equals(fileId)){
					fileId=getFix("yyyyMM")+IdHelp.getUUID30();
					comFile.setFileId(fileId);
					dataBean.setFileId(fileId);
					comFileDao.save(comFile);
				}else {
					comFileDao.update(comFile);
				}
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		dataBean.setCreateTime(getFix("yyyy-MM-dd"));
		service.update(dataBean);
		
	}
	@Trans
	public void report(){
		Record record = (Record) getParameter("record"); 
		String noticeId=(String)record.get("NOTICE_ID");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("NOTICE_ID", noticeId);
		CdcNoticeInfo dataBean=(CdcNoticeInfo)service.query(pset).getRecord(0).toBean(CdcNoticeInfo.class);
		dataBean.setFlag("1");
		service.update(dataBean);
		
	}
	
	@Trans
	public void delete(){
		Record[] records = (Record[]) getParameter("records"); 
		for(int i=0;i<records.length;i++){
			//CdcNoticeInfo cdcNoticeInfo =(CdcNoticeInfo)records[i].toBean(CdcNoticeInfo.class);
			String noticeId= (String)records[i].get("NOTICE_ID");
			String fileId= (String)records[i].get("FILE_ID");
			comFileDao.delete(fileId);
			service.delete(noticeId);
		}
		
	}
	private String getFix(String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date());
	}
}
